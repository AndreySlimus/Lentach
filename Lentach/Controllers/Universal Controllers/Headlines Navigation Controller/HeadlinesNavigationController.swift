//
//  HeadlinesNavigationController.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//

import UIKit

class HeadlinesNavigationController: UINavigationController {

    // MARK: - Constants
    private struct Constants {

        static let foregroundColor = UIColor.white
        static let font = "Akrobat-SemiBold"
        static let standardFontSize: CGFloat = 20
        static let largeFontSize: CGFloat = 30
        static let standardTitleFont = UIFont.init(name: font, size: standardFontSize)
        static let largeTitleFont = UIFont.init(name: font, size: largeFontSize)

        static let standardTitleTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: Constants.foregroundColor,
            NSAttributedString.Key.font: Constants.standardTitleFont as Any
        ]

        static let largeTitleTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: Constants.foregroundColor,
            NSAttributedString.Key.font: Constants.largeTitleFont as Any
        ]
    }

    // MARK: - Lifecycle
    // MARK: -- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        settings()
    }

    // MARK: - Private Methods
    // MARK: -- Settings UI
    private func settings() {

        self.navigationBar.titleTextAttributes = Constants.standardTitleTextAttributes
        self.navigationBar.largeTitleTextAttributes = Constants.largeTitleTextAttributes
        self.navigationBar.barTintColor = .lentachGray
        self.navigationBar.isTranslucent = false
        self.navigationBar.tintColor = .white
    }

}
