//
//  LentachLabel.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//

import UIKit

class LentachLabel: UILabel {

    // MARK: - Constants
    private struct Constants {

        static let standardFontName = "Akrobat-SemiBold"
        static let standardFontSize: CGFloat = 15.0
        static let standardFont = UIFont.init(name: Constants.standardFontName,
                                              size: Constants.standardFontSize)
    }

    // MARK: - Lifecycle
    // MARK: -- Initializati
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.settings()
    }

    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)

        self.settings()
    }

    convenience init(frame: CGRect,
                     fontName: String = Constants.standardFontName,
                     fontSize: CGFloat = Constants.standardFontSize,
                     textColor: UIColor = .lentachGray) {
        self.init(frame: frame)

        self.font = UIFont.init(name: fontName, size: fontSize)
        self.textColor = textColor
    }

    // MARK: - Private Methods
    // MARK: -- Settings UI
    fileprivate func settings() {

        self.font = Constants.standardFont
        self.textColor = .lentachGray
        self.contentMode = .scaleToFill
        self.numberOfLines = 0
        self.textAlignment = .left
    }

}
