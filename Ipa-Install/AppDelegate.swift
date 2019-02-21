//
//  AppDelegate.swift
//  Ipa-Install
//
//  Created by nich on 2019/2/21.
//  Copyright © 2019 nich. All rights reserved.
//

import UIKit
import Tiercel
import Swifter

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    static let server = HttpServer()
    static var backgroundTaskId : UIBackgroundTaskIdentifier? = nil

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) {
        if TRManager.default.identifier == identifier {
            TRManager.default.completionHandler = completionHandler
        }
    }
    
    static func startServer() {
        server.stop()
        do {
            backgroundTaskId = UIApplication.shared.beginBackgroundTask(withName: "Ipa-Install", expirationHandler: {
                print("Server stop")
                self.server.stop()
            })
            server.listenAddressIPv4 = "127.0.0.1"
            server["/:path"] = shareFilesFromDirectory(TRManager.default.cache.downloadFilePath)
            try server.start(8090, forceIPv4: true)
            NSLog("Server started: Operating: \(server.operating)")
        } catch {
            NSLog("Server failed to start.")
        }
    }


}

