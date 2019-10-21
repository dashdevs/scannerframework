//
//  ListTableViewStateMachineController.swift
//  GoodsScanner
//
//  Created by Alexander Kozlov on 9/25/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import UIKit

public enum GetRequestOperationType: Int {
    case filter
    case refresh
    case load
}

private struct Constants {
    static let minimumSearchLength: Int = 2
    static let loadingSectionIndex: Int = 1
    static let normalSectionAmount: Int = 1
    static let loadingSectionAmount: Int = 2
}

open class ListTableViewStateMachineController<Model, ViewModel>: StateMachineTableViewController, UISearchResultsUpdating, UISearchBarDelegate {
    private var modelsTotalCount: Int = 0
    private var models = [Model]()
    private var activeTask: URLSessionTask?
    private var searchController: UISearchController?
    private var isLoading: Bool = false {
        didSet {
            showLoading(isLoading)
            guard isLoading == false, isRefreshing, !tableView.isDragging else { return }
            isRefreshing = false
        }
    }
    
    private var isRefreshing: Bool = false {
        didSet {
            guard !isRefreshing else { return }
            refreshControl?.endRefreshing()
            tableView.reloadData()
        }
    }
    
    private var getBranchesOperation: GetRequestOperationType = .load
    
    private var searchText: String {
        return searchController?.searchBar.text ?? ""
    }
    
    private var isFetchAllowed: Bool {
        return searchText.count >= Constants.minimumSearchLength || searchText.isEmpty
    }
    
    private var nextPageFetchIndex: Int = 0
    
    public var selectedModel: Model?
    public var convertModel: ((Model) -> ViewModel)!
    public var fetchRequest: ((String, Int) -> URLSessionTask?)!
    public var searchPlaceHolder: String? = L10n.searchPlaceholder {
        didSet {
            searchController?.searchBar.placeholder = searchPlaceHolder
        }
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if #available(iOS 11.0, *) {
        } else {
            setupSearchController()
        }
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        searchController?.onDisappear()
    }
    
    deinit {
        activeTask?.cancel()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    // MARK: - Private
    
    private func setup() {
        tableView.register(UINib.refreshCellNib, forCellReuseIdentifier: RefreshTableViewCell.reuseIdentifier)
        setupRefreshControl()
        if #available(iOS 11.0, *) {
            setupSearchController()
        }
    }
    
    private func setupSearchController() {
        let searchController = UISearchController.appSearchController(placeholder: searchPlaceHolder)
        searchController.searchResultsUpdater = self
        
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            searchController.searchBar.delegate = self
            tableView.tableHeaderView = searchController.searchBar
        }
        
        self.searchController = searchController
    }
    
    private func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(reloadBranches(_:)), for: .valueChanged)
        self.refreshControl = refreshControl
    }
    
    private func isNeedFetch(for indexPath: IndexPath) -> Bool {
        guard models.count < modelsTotalCount else { return false }
        return isLoading ? false : indexPath.row >= nextPageFetchIndex
    }
    
    @objc private func reloadBranches(_ sender: Any? = nil) {
        isRefreshing = true
        fetchModels(for: .refresh)
    }
    
    // MARK: - Public
    
    open func fetchModels(for operation: GetRequestOperationType = .load) {
        guard isFetchAllowed else { return }
        activeTask?.cancel()
        getBranchesOperation = operation
        let offset = operation == .load ? models.count : 0
        activeTask = fetchRequest(searchText, offset)
    }
    
    open func getDataCell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    public func handleFetchedModels(_ models: [Model], totalAmount: ModelID) {
        if getBranchesOperation != .load {
            self.models.removeAll()
            modelsTotalCount = 0
        }
        nextPageFetchIndex = self.models.count + models.count / 2
        self.models.append(contentsOf: models)
        modelsTotalCount = Int(totalAmount)
    }
    
    public func getViewModel(for index: Int) -> ViewModel {
        return convertModel(models[index])
    }
    
    // MARK: - State Machine
    
    open override func handleContainer(_ container: Container) {
        isLoading = false
        guard !isRefreshing else { return }
        tableView.reloadData()
    }
    
    open override func handleErrors(_ error: Error) {
        if let error = error as? URLError, error.code == .cancelled, activeTask?.state != .canceling {
            return
        }
        isLoading = false
        super.handleErrors(error)
    }
    
    open override func setLoading() {
        isLoading = true
    }
    
    // MARK: - UITableViewDelegate
    
    open override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard isNeedFetch(for: indexPath) else { return }
        fetchModels()
    }
    
    open override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row < models.count else { return }
        selectedModel = models[indexPath.row]
    }
    
    open override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard isLoading == false, isRefreshing else { return }
        isRefreshing = false
    }
    
    // MARK: - UITableViewDataSource
    
    open override func numberOfSections(in tableView: UITableView) -> Int {
        return models.count < modelsTotalCount ? Constants.loadingSectionAmount : Constants.normalSectionAmount
    }
    
    open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == Constants.loadingSectionIndex ? 1 : models.count
    }
    
    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.section == Constants.loadingSectionIndex else {
            return getDataCell(for: tableView, at: indexPath)
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: RefreshTableViewCell.reuseIdentifier, for: indexPath) as! RefreshTableViewCell
        cell.startAnimating()
        return cell
    }
    
    // MARK: - UISearchResultsUpdating
    
    public func updateSearchResults(for searchController: UISearchController) {
        fetchModels(for: .filter)
    }
    
    // MARK: - UISearchBarDelegate
    
    public func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchController?.isActive = false
    }
}
