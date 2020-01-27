//
//  GalleryViewController.swift
//  GoodsScanner
//
//  Created by Alexander Kozlov on 9/11/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import UIKit

protocol GalleryViewProtocol {
    func addImage(_ image: UIImage, needUpdate: Bool)
}

public typealias PrepareDocumentInfo = (orderId: ModelID, documentFileName: String)

class GalleryViewController: StateMachineCollectionViewController {
    private struct Constants {
        static let cellReuseIdentifier = "thumbCellReuseIdentifier"
        static let normalAmountCellInRow: CGFloat = 4
        static let smallAmountCellInRow: CGFloat = 2
        static let ruLocale = Locale(identifier: "ru")
        static let bundle = Bundle(for: GalleryViewController.self)
        static let countPhotoFormatString = NSLocalizedString("count photos", tableName: nil, bundle: bundle, comment: "")
    }
    
    @IBOutlet private weak var cancelButton: UIBarButtonItem!
    @IBOutlet private weak var doneButton: UIBarButtonItem!
    @IBOutlet private weak var deleteButton: UIBarButtonItem!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var containerView: UIView!
    
    var prepareDocumentInfo: PrepareDocumentInfo!
    var doneAction: (() -> Void)?
    var photoAction: (() -> Void)?
    var unfinishedProducts: [OrderProductModel]?
    
    private let repo = DataRepository()
    
    private var viewModels = [ThumbImageViewModel]() {
        didSet {
            setImageActionsState(!viewModels.isEmpty)
        }
    }
    
    private lazy var amounCellInRow: CGFloat = {
        UIScreen.main.isSmallScreen ? Constants.smallAmountCellInRow : Constants.normalAmountCellInRow
    }()
    
    private var isLoading: Bool = false {
        didSet {
            doneButton.isEnabled = !isLoading
            containerView.isHidden = !isLoading
            containerView.layer.zPosition = isLoading ? collectionView.layer.zPosition + 1 : 0.0
            isLoading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localize()
        setup()
    }
    
    // MARK: - Private
    
    private func setup() {
        navigationController?.setToolbarHidden(false, animated: true)
        repo.handler = self
    }
    
    private func setImageActionsState(_ enabled: Bool) {
        doneButton.isEnabled = enabled
        deleteButton.isEnabled = enabled
    }
    
    private func onClose() {
        navigationController?.setToolbarHidden(true, animated: true)
        doneAction?()
    }
    
    private func uploadDocument() {
        let images = viewModels.filter { $0.isChecked }.map { $0.image }
        guard let pdfData = PDFDocumentPreparer.createPDF(for: images) else { return }
        let model = UploadDocumentModel(filename: prepareDocumentInfo.documentFileName, data: pdfData)
        repo.uploadDocument(orderID: prepareDocumentInfo.orderId, model: model)
    }
    
    private func getCountPhotoSpelled(for count: Int) -> String {
        return String(format: Constants.countPhotoFormatString, locale: Constants.ruLocale, count)
    }
    
    private func askToDeletePhotos() {
        let countToDelete = viewModels.filter { $0.isChecked }.count
        guard countToDelete > 0 else { return }
        let spelledPhotoCount = getCountPhotoSpelled(for: countToDelete)
        let actionController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionController.addAction(UIAlertAction(title: L10n.deleteConfirmationTitle(spelledPhotoCount), style: .destructive, handler: { [weak self] _ in
            self?.deletePhotos()
        }))
        actionController.addAction(UIAlertAction(title: L10n.cancelTitle, style: .cancel, handler: nil))
        present(actionController, animated: true, completion: nil)
    }
    
    private func deletePhotos() {
        viewModels = viewModels.filter { !$0.isChecked }
        collectionView.reloadData()
    }
    
    private func finishProducts() {
        guard let productModel = unfinishedProducts?.first else {
            uploadDocument()
            return
        }
        var dueDate: Int?
        if let dueDateSeconds = productModel.dueDate?.timeIntervalSince1970 {
            dueDate = Int(dueDateSeconds)
        }
        repo.updateProductOrder(orderID: prepareDocumentInfo.orderId,
                                productID: productModel.id,
                                model: ProductUpdateModel(price: productModel.expectedPrice.doubleValue,
                                                          expectedCount: productModel.expectedCount.doubleValue,
                                                          actualCount: productModel.expectedCount.doubleValue,
                                                          dueDate: dueDate))
    }
    
    // MARK: - Actions
    
    @IBAction func onCancelTap(_ sender: Any) {
        onClose()
    }
    
    @IBAction func onDoneTap(_ sender: Any) {
        guard unfinishedProducts?.isEmpty == false else {
            uploadDocument()
            return
        }
        finishProducts()
    }
    
    @IBAction func onDeleteTap(_ sender: Any) {
        askToDeletePhotos()
    }
    
    @IBAction func onPhotoTap(_ sender: Any) {
        photoAction?()
    }
    
    // MARK: State Machine
    
    override func handleContainer(_ container: Container) {
        isLoading = false
        switch container {
        case .order: onClose()
        case let Container.orderProduct(productModel):
            guard let index = unfinishedProducts?.firstIndex(where: { model in
                model.id == productModel.id
            }) else {
                finishProducts()
                return
            }
            unfinishedProducts?.remove(at: index)
            finishProducts()
        default: super.handleContainer(container)
        }
        guard case Container.order = container else { return }
        onClose()
    }
    
    override func handleErrors(_ error: Error) {
        isLoading = false
        super.handleErrors(error)
    }
    
    override func setLoading() {
        isLoading = true
    }
}

extension GalleryViewController: Localizable {
    func localize() {
        title = L10n.documentsTitle
        cancelButton.title = L10n.cancelTitle
        doneButton.title = L10n.doneTitle
    }
}

extension GalleryViewController: GalleryViewProtocol {
    func addImage(_ image: UIImage, needUpdate: Bool = false) {
        viewModels.append(ThumbImageViewModel(image: image))
        setImageActionsState(true)
        guard needUpdate else { return }
        collectionView.reloadData()
    }
}

extension GalleryViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellReuseIdentifier, for: indexPath) as! ThumbImageCollectionViewCell
        cell.configure(with: viewModels[indexPath.row]) { [weak self] checked in
            self?.viewModels[indexPath.row].isChecked = checked
            self?.collectionView.reloadData()
        }
        return cell
    }
}

extension GalleryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else { return .zero }
        let totalSpace = layout.sectionInset.left + layout.sectionInset.right + layout.minimumInteritemSpacing * (amounCellInRow - 1)
        let size = (collectionView.bounds.width - totalSpace) / amounCellInRow
        return CGSize(width: size, height: size)
    }
}
