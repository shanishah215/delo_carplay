import UIKit
import Flutter
import Foundation

let flutterEngine = FlutterEngine(name: "SharedEngine", project: nil, allowHeadlessExecution: true)


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    private var communicator: FlutterCommunicator?
    override func application( _ application: UIApplication,
                               didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        flutterEngine.run()
        if let controller = flutterEngine.viewController {
            // refer to this link https://developer.apple.com/documentation/applemusicapi/generating_developer_tokens
            AppleMusicAPIController.developerToken = ""
            communicator = FlutterCommunicator(controller)
        }
        GeneratedPluginRegistrant.register(with: flutterEngine)
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions);
        
    }
}
