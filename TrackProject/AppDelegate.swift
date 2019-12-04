//
//  AppDelegate.swift
//  TrackProject
//
//  Created by Денис Дубовиков on 29/09/2019.
//  Copyright © 2019 Денис Дубовиков. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow()
        window?.makeKeyAndVisible()
        window?.rootViewController = StartScreen()
        
        print("Func: didFinishLaunchingWithOptions. Tells the delegate that the launch process is almost done and the app is almost ready to run.")
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        print("Func: applicationDidBecomeActive. Tells the delegate that the app has become active.")
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        print("Func: applicationWillResignActive. Tells the delegate that the app is about to become inactive.")
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("Func: applicationDidEnterBackground. Tells the delegate that the app is now in the background.")
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        print("Func: applicationWillEnterForeground. Tells the delegate that the app is about to enter the foreground.")
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        print("Func: applicationWillTerminate. Tells the delegate when the app is about to terminate.")
    }
    
    
    
    

    // MARK: UISceneSession Lifecycle

//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        print("Func: configurationForConnecting. Returns the configuration data for UIKit to use when creating a new scene.")
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//        print("Func: didDiscardSceneSessions. Tells the delegate that the user closed one or more of the app's scenes from the app switcher.")
//    }

    
    // MARK: - Core Data stack
    
    var managedObjectContext: NSManagedObjectContext
    {
        persistentContainer.viewContext
    }

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "MyDataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

