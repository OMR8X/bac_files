import UIKit
import Flutter
import flutter_background_service_ios // add this
@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
     /// Add this line
    SwiftFlutterBackgroundServicePlugin.taskIdentifier = "testing.background.refresh"
    // Just initialize Flutter and the generated plugin registrant
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
