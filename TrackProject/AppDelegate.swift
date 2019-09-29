//
//  AppDelegate.swift
//  TrackProject
//
//  Created by Денис Дубовиков on 29/09/2019.
//  Copyright © 2019 Денис Дубовиков. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        print("Func: didFinishLaunchingWithOptions. Tells the delegate that the launch process is almost done and the app is almost ready to run.")
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        print("Func: configurationForConnecting. Returns the configuration data for UIKit to use when creating a new scene.")
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
        print("Func: didDiscardSceneSessions. Tells the delegate that the user closed one or more of the app's scenes from the app switcher.")
    }


}

