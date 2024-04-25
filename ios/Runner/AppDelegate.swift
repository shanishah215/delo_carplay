
import UIKit
import Flutter
import Foundation
import CarPlay
import MediaPlayer

let flutterEngine = FlutterEngine(name: "SharedEngine", project: nil, allowHeadlessExecution: true)


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    let call = SwiftMusicPlayerPlugin()
    override func application( _ application: UIApplication,
                               didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        flutterEngine.run()
        GeneratedPluginRegistrant.register(with: flutterEngine)
        call.register(with: flutterEngine)

        setupNowPlayingInfoCenter()

        #if targetEnvironment(simulator)
            UIApplication.shared.endReceivingRemoteControlEvents()
            UIApplication.shared.beginReceivingRemoteControlEvents()
        #endif
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions);
        
    }

    private func setupNowPlayingInfoCenter() {
        UIApplication.shared.beginReceivingRemoteControlEvents()
        MPRemoteCommandCenter.shared().playCommand.isEnabled = true
        MPRemoteCommandCenter.shared().playCommand.addTarget { event in
          return .success
        }
        
        MPRemoteCommandCenter.shared().pauseCommand.isEnabled = true
        MPRemoteCommandCenter.shared().pauseCommand.addTarget { event in
          return .success
        }
        
        MPRemoteCommandCenter.shared().changePlaybackPositionCommand.isEnabled = true
        MPRemoteCommandCenter.shared().changePlaybackPositionCommand.addTarget { event in
          return .success
        }
        

      }
}

public class SwiftMusicPlayerPlugin: NSObject {
    
    public func register(with registrar: FlutterEngine) {
        let channel = FlutterMethodChannel(name: "music_player", binaryMessenger: registrar.binaryMessenger)
        channel.setMethodCallHandler {(call: FlutterMethodCall, result: FlutterResult) -> Void in
            switch(call.method) {
            case "playMusic":
                let params = call.arguments as? [String: Any]
//                print(params)
                Task {
                    await self.playMusic(params: params ?? [:])
                }
                
                break;
            default: result(FlutterMethodNotImplemented)
            }
        }
    }

    var player = AVPlayer()
    private func playMusic(params: [String: Any]) async {
//        print("**** DATA:: params[link]:: ", params["link"])
//        print("**** DATA:: params[duration]:: ", params["duration"])
        let playerItem = AVPlayerItem(url: URL(string: params["link"] as? String ?? "")!)
        player = AVPlayer(playerItem: playerItem)
        player.volume = 0.6;
        player.allowsExternalPlayback = true
        player.usesExternalPlaybackWhileExternalScreenIsActive = true

        if let imageUrlString = params["img"] as? String, let imageUrl = URL(string: imageUrlString) {
            Task.init {
                do {
                    let (data, response) = try await URLSession.shared.data(from: imageUrl)
                    let imageData = data
                    var nowPlayingInfo: [String: Any] = [:]
                    if let image = UIImage(data: imageData) {
                        let coverArt = MPMediaItemArtwork(boundsSize: image.size, requestHandler: { size -> UIImage in
                            return image
                         })
                         nowPlayingInfo = [
                            MPMediaItemPropertyArtwork: coverArt,
                            MPMediaItemPropertyTitle: params["title"] as? String ?? "undefined",
                            MPMediaItemPropertyArtist: params["artist"] as? String ?? "undefined",
                            MPMediaItemPropertyGenre: "",
                            MPMediaItemPropertyPlaybackDuration: "4",
//                                params["duration"] as? String ?? "",
                            MPMediaItemPropertyAssetURL: params["link"] as? String ?? ""
                        ]
                        Task {
                            await player.play()
                        }
                        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
                        MPPlayableContentManager.shared().nowPlayingIdentifiers = []
                    } else {
                        print("Failed to create UIImage from data")
                    }
                } catch {
                    print("Error loading image data: \(error)")
                }
            }
        } else {
            print("Invalid image URL")
        }



        //        CPNowPlayingTemplate.shared.isAlbumArtistButtonEnabled = true
        //        MPMusicPlayerController.applicationQueuePlayer.setQueue(with: ["yjhT3QRS"])
        //        MPMusicPlayerController.applicationQueuePlayer.prepareToPlay()
        //        MPMusicPlayerController.applicationQueuePlayer.play()
        
        

//        let musicPlayerController = MPMusicPlayerController.systemMusicPlayer
        
//        musicPlayerController.setQueue(with: MPMediaQuery.songs())
//        musicPlayerController.play()

//        MPMusicPlayerController.applicationQueuePlayer.pause()
//        let item = MPMediaItem()
//        item.url
//        let query = MPMediaItemCollection(items: [item])
        
//        let nowPlayingInfoCenter = MPNowPlayingInfoCenter.default()
//        var nowPlayingInfo = [String:Any]()
//        

        
//        CPNowPlayingTemplate.shared.tabTitle = "chandan"
    }
}


//public let MPMediaItemPropertyPersistentID: String
//public let MPMediaItemPropertyMediaType: String
//public let MPMediaItemPropertyTitle: String
//public let MPMediaItemPropertyAlbumTitle: String
//public let MPMediaItemPropertyAlbumPersistentID: String
//public let MPMediaItemPropertyArtist: String
//public let MPMediaItemPropertyArtistPersistentID: String
//public let MPMediaItemPropertyAlbumArtist: String
//public let MPMediaItemPropertyAlbumArtistPersistentID: String
//
//public let MPMediaItemPropertyGenre: String
//public let MPMediaItemPropertyGenrePersistentID: String
//
//public let MPMediaItemPropertyComposer: String
//public let MPMediaItemPropertyComposerPersistentID: String
//
//public let MPMediaItemPropertyPlaybackDuration: String
//
//public let MPMediaItemPropertyAlbumTrackNumber: String
//
//public let MPMediaItemPropertyAlbumTrackCount: String
//
//public let MPMediaItemPropertyDiscNumber: String
//
//public let MPMediaItemPropertyDiscCount: String
//
//public let MPMediaItemPropertyArtwork: String
//public let MPMediaItemPropertyIsExplicit: String
//
//public let MPMediaItemPropertyLyrics: String
//
//public let MPMediaItemPropertyIsCompilation: String
//
//public let MPMediaItemPropertyReleaseDate: String
//
//public let MPMediaItemPropertyBeatsPerMinute: String
//public let MPMediaItemPropertyComments: String
//
//public let MPMediaItemPropertyAssetURL: String
//public let MPMediaItemPropertyIsCloudItem: String
//public let MPMediaItemPropertyHasProtectedAsset: String
//
//public let MPMediaItemPropertyPodcastTitle: String
//public let MPMediaItemPropertyPodcastPersistentID: String
//
//public let MPMediaItemPropertyPlayCount: String
//
//public let MPMediaItemPropertySkipCount: String
//
//public let MPMediaItemPropertyRating: String
//
//public let MPMediaItemPropertyLastPlayedDate: String
//
//public let MPMediaItemPropertyUserGrouping: String
//public let MPMediaItemPropertyBookmarkTime: String
//public let MPMediaItemPropertyDateAdded: String
//public let MPMediaItemPropertyPlaybackStoreID: String
//public let MPMediaItemPropertyIsPreorder: String
