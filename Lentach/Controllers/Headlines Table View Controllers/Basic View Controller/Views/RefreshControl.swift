//
//  RefreshControl.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//

import UIKit

class RefreshControl: UIRefreshControl {

    // MARK: - Class Methods
    class func standardStyle() -> RefreshControl {

        let refreshControl = RefreshControl.init(frame: CGRect.zero)

        return refreshControl
    }

    // MARK: - Private Properties
    // MARK: -- UI Properties
    private let titleAttributes = [
        NSAttributedString.Key.foregroundColor: UIColor.lightGray,
        NSAttributedString.Key.font: UIFont.init(name: "Akrobat-SemiBold", size: 17) as Any
    ]

    // MARK: - Lifecycle
    // MARK: -- Initializations
    override init(frame: CGRect) {
        super.init(frame: frame)

        settings()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        settings()
    }

    // MARK: - Private Methods
    // MARK: -- Settings UI
    private func settings() {

        self.backgroundColor = .lentachGray
        self.tintColor = .white

        self.attributedTitle = NSAttributedString(string: "Обновить",
                                                  attributes: self.titleAttributes)
    }

}
