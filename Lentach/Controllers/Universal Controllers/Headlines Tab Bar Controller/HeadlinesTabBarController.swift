//
//  HeadlinesTabBarController.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//

import UIKit

class HeadlinesTabBarController: UITabBarController {

    // MARK: - Constants
    private struct Constants {

        static let isTranslucent = false
        static let barTintColor = UIColor.lentachGray
        static let tintColor = UIColor.white
        static let font = "Akrobat-SemiBold"
        static let standardFontSize: CGFloat = 12
        static let standardTitleFont = UIFont.init(name: font, size: standardFontSize)

        static let standardTitleTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: Constants.standardTitleFont as Any
        ]
    }

    // MARK: - Private Properties
    // MARK: -- UI Properties
    private lazy var latestHeadlinesImage: UIImage? = {
        return UIImage.init(named: "latest-news")
    }()

    private lazy var popularHeadlinesImage: UIImage? = {
        return UIImage.init(named: "popular-news")
    }()

    private lazy var favoritesHeadlinesImage: UIImage? = {
        return UIImage.init(named: "favorites-news")
    }()

    private lazy var latestHeadlinesTabBar: UITabBarItem = {

        let tabBarItem = UITabBarItem.init(title: "Последнее",
                                           image: self.latestHeadlinesImage,
                                           selectedImage: self.latestHeadlinesImage)

        tabBarItem.setTitleTextAttributes(Constants.standardTitleTextAttributes, for: .normal)
        tabBarItem.setTitleTextAttributes(Constants.standardTitleTextAttributes, for: .selected)

        return tabBarItem
    }()

    private lazy var popularHeadlinesTabBar: UITabBarItem = {

        let tabBarItem = UITabBarItem.init(title: "Популярное",
                                           image: self.popularHeadlinesImage,
                                           selectedImage: self.popularHeadlinesImage)

        tabBarItem.setTitleTextAttributes(Constants.standardTitleTextAttributes, for: .normal)
        tabBarItem.setTitleTextAttributes(Constants.standardTitleTextAttributes, for: .selected)

        return tabBarItem
    }()

    private lazy var favoritesHeadlinesTabBar: UITabBarItem = {

        let tabBarItem = UITabBarItem.init(title: "Избранное",
                                           image: self.favoritesHeadlinesImage,
                                           selectedImage: self.favoritesHeadlinesImage)

        tabBarItem.setTitleTextAttributes(Constants.standardTitleTextAttributes, for: .normal)
        tabBarItem.setTitleTextAttributes(Constants.standardTitleTextAttributes, for: .selected)

        return tabBarItem
    }()

    private lazy var latestHeadlinesViewController: LatestHeadlinesViewController? = {

        let storyboard = UIStoryboard.init(name: "LatestHeadlinesViewController", bundle: nil)

        guard let latestHeadlinesViewController = storyboard.instantiateViewController(withIdentifier: "LatestHeadlinesViewController") as? LatestHeadlinesViewController else {
            return nil
        }

        return latestHeadlinesViewController
    }()

    private lazy var popularHeadlinesViewController: PopularHeadlinesViewController? = {

        let storyboard = UIStoryboard.init(name: "PopularHeadlinesViewController", bundle: nil)

        guard let popularHeadlinesViewController = storyboard.instantiateViewController(withIdentifier: "PopularHeadlinesViewController") as? PopularHeadlinesViewController else {
            return nil
        }

        return popularHeadlinesViewController
    }()

    private lazy var favoritesHeadlinesViewController: FavoritesHeadlinesViewController? = {

        let storyboard = UIStoryboard.init(name: "FavoritesHeadlinesViewController", bundle: nil)

        guard let favoritesHeadlinesViewController = storyboard.instantiateViewController(withIdentifier: "FavoritesHeadlinesViewController") as? FavoritesHeadlinesViewController else {
            return nil
        }

        return favoritesHeadlinesViewController
    }()

    // MARK: - Lifecycle
    // MARK: -- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        settings()
        settingsViewControllers()

    }

    // MARK: - Private Methods
    // MARK: -- Settings UI
    private func settings() {

        self.tabBar.tintColor = Constants.tintColor
        self.tabBar.barTintColor = Constants.barTintColor
        self.tabBar.isTranslucent = Constants.isTranslucent
    }

    private func settingsViewControllers() {

        guard
            let latestHeadlinesViewController = self.latestHeadlinesViewController,
            let popularHeadlinesViewController = self.popularHeadlinesViewController,
            let favoritesHeadlinesViewController = self.favoritesHeadlinesViewController
            else {
                return
        }

        // latest vc
        let latestHeadlinesNavigationController = HeadlinesNavigationController.init(rootViewController:
            latestHeadlinesViewController)

        latestHeadlinesNavigationController.tabBarItem = self.latestHeadlinesTabBar

        // popular vc
        let popularHeadlinesNavigationController = HeadlinesNavigationController.init(rootViewController: popularHeadlinesViewController)

        popularHeadlinesNavigationController.tabBarItem = self.popularHeadlinesTabBar

        // faforites vc
        let favoritesHeadlinesNavigationController = HeadlinesNavigationController.init(rootViewController: favoritesHeadlinesViewController)

        favoritesHeadlinesNavigationController.tabBarItem = self.favoritesHeadlinesTabBar

        self.viewControllers = [
            latestHeadlinesNavigationController,
            popularHeadlinesNavigationController,
            favoritesHeadlinesNavigationController
        ]
    }

}
