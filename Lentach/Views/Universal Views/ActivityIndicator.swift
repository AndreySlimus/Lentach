//
//  ActivityIndicator.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//

import UIKit

class ActivityIndicator: UIActivityIndicatorView {

    // MARK: - Class Methods
    class func standardStyle() -> ActivityIndicator {

        let activityIndicator = ActivityIndicator.init(frame: CGRect.init(x: 0,
                                                                          y: 0,
                                                                          width: Constants.standardSize,
                                                                          height: Constants.standardSize))
        return activityIndicator
    }

    // MARK: - Constants
    private struct Constants {

        static let standardSize: CGFloat = 100.0
    }

    // MARK: - Lifecycle
    // MARK: -- Initializations
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.settings()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)

        self.settings()
    }

    convenience init(width: CGFloat = Constants.standardSize,
                     height: CGFloat = Constants.standardSize,
                     inCenter view: UIView) {

        self.init(frame: CGRect.init(x: 0, y: 0, width: width, height: height))

        self.center = view.center

        view.addSubview(self)
    }

    // MARK: - Private Methods
    // MARK: -- Settings UI
    private func settings() {

        self.hidesWhenStopped = true
    }

}
