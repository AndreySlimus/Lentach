//
//  AppDelegate.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // path to core data files
        let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory,
                                                       .userDomainMask,
                                                       true)

        print(path[0] + "/Application Support")

        // create directory for locally storage images
        ImagesFileManager.createDirectory()

        // initialization of the start lentachTabBarController
        let headlinesTabBarController = HeadlinesTabBarController()

        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = headlinesTabBarController
        self.window?.makeKeyAndVisible()

        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        CoreDataManager.shared.saveContext()
    }

}
