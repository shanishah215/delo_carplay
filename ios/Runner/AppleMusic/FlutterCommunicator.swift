//
//  FlutterCommunicator.swift
//  Runner
//
//  Created by Chandan Sharda on 19/04/24.
//

import Flutter
import Foundation
import UIKit
import Intents
import os.log
import MediaPlayer
import CoreSpotlight

class FlutterCommunicator {

    let channel: FlutterMethodChannel
    let appleController: AppleMusicAPIController
    private let context = INMediaUserContext()

    init(_ controller: FlutterViewController) {
        channel = FlutterMethodChannel(name: "apple-music-channel-ios", binaryMessenger: controller.binaryMessenger)
        appleController = AppleMusicAPIController()

        startListining()
    }

    private func requestAuth(result: @escaping ([String: Any]) -> Void) {
        // Let the system know the app can be an option for playing Music.
        DispatchQueue.global(qos: .userInitiated).async {
            self.context.numberOfLibraryItems = MPMediaQuery.songs().items?.count
            self.appleController.prepareForRequests { (success) in
                if success {
                    self.context.subscriptionStatus = .subscribed
                    result(["success": "true"])
                } else {
                    self.context.subscriptionStatus = .notSubscribed
                    result(["success": "false", "message": "notSubscribed"])
                }
                self.context.becomeCurrent()
            }
        }
    }

    private func startListining() {
        channel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
            switch call.method {
            case "connectedToCarPlay":
                self.requestAuth { resultSuccess in
                    result(resultSuccess)
                }

            case "getGenre":
                result(self.sendGenere())

            case "getGenereDetailsByItem":
                let arguments = call.arguments as? [String: Any] ?? [:]
                if let genre = arguments["genre"] as? String {
                    self.getGenereDetails(text: genre) { songs in
                        result(songs)
                    }
                }
            default:
                result(FlutterMethodNotImplemented)
            }
        }
    }

    private func getGenereDetails(text: String, completion: @escaping ([String: Any]) -> Void) {
        AppleMusicAPIController.sharedController.searchForTerm(text) { items in
            if let songs = items {
                let data = try? JSONEncoder().encode(items)
                let keyValues = try? JSONSerialization.jsonObject(with: data ?? Data())
                completion(["songs": keyValues as Any])
            }
        }
    }

    private func sendGenere() -> [String: Any] {
        let arr = [
            ["text": "Reggae", "detailText": "Relax and feel good.", "systemImage": "sun.max"],
            ["text": "Jazz", "detailText": "How about some smooth jazz.", "systemImage": "music.note.house"],
            ["text": "Alternative", "detailText": "Catch a vibe.", "systemImage": "guitars.fill"],
            ["text": "Hip-Hop", "detailText": "Play the latest jams.", "systemImage": "music.mic"]
        ]
        let data: [String: Any] = ["genre": arr]
        return data
    }
}
