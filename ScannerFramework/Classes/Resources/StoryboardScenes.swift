// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

// swiftlint:disable sorted_imports
import Foundation
import UIKit

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Storyboard Scenes

// swiftlint:disable explicit_type_interface identifier_name line_length type_body_length type_name
internal enum StoryboardScene {
  internal enum Auth: StoryboardType {
    internal static let storyboardName = "Auth"

    internal static let initialScene = InitialSceneType<UIKit.UINavigationController>(storyboard: Auth.self)

    internal static let emailAuth = SceneType<ScannerFramework.EmailAuthViewController>(storyboard: Auth.self, identifier: "EmailAuth")

    internal static let emailConfirm = SceneType<ScannerFramework.EmailConfirmViewController>(storyboard: Auth.self, identifier: "EmailConfirm")

    internal static let phoneAuth = SceneType<ScannerFramework.PhoneAuthViewController>(storyboard: Auth.self, identifier: "PhoneAuth")

    internal static let phoneConfirm = SceneType<ScannerFramework.PhoneConfirmViewController>(storyboard: Auth.self, identifier: "PhoneConfirm")
  }
  internal enum PrepareDocument: StoryboardType {
    internal static let storyboardName = "PrepareDocument"

    internal static let cameraScreen = SceneType<ScannerFramework.CameraViewController>(storyboard: PrepareDocument.self, identifier: "CameraScreen")

    internal static let gallery = SceneType<ScannerFramework.GalleryViewController>(storyboard: PrepareDocument.self, identifier: "Gallery")
  }
  internal enum ShowDocument: StoryboardType {
    internal static let storyboardName = "ShowDocument"

    internal static let documentViewer = SceneType<ScannerFramework.DocumentViewerViewController>(storyboard: ShowDocument.self, identifier: "DocumentViewer")
  }
}
// swiftlint:enable explicit_type_interface identifier_name line_length type_body_length type_name

// MARK: - Implementation Details

internal protocol StoryboardType {
  static var storyboardName: String { get }
}

internal extension StoryboardType {
  static var storyboard: UIStoryboard {
    let name = self.storyboardName
    return UIStoryboard(name: name, bundle: Bundle(for: BundleToken.self))
  }
}

internal struct SceneType<T: UIViewController> {
  internal let storyboard: StoryboardType.Type
  internal let identifier: String

  internal func instantiate() -> T {
    let identifier = self.identifier
    guard let controller = storyboard.storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
      fatalError("ViewController '\(identifier)' is not of the expected class \(T.self).")
    }
    return controller
  }
}

internal struct InitialSceneType<T: UIViewController> {
  internal let storyboard: StoryboardType.Type

  internal func instantiate() -> T {
    guard let controller = storyboard.storyboard.instantiateInitialViewController() as? T else {
      fatalError("ViewController is not of the expected class \(T.self).")
    }
    return controller
  }
}

private final class BundleToken {}
