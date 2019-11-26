//
//  NetworkConnectionErrorView.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//

import UIKit

class NetworkConnectionErrorView: UIView {

    // MARK: - Class Methods
    class func instanceFromNib() -> NetworkConnectionErrorView? {

        let nib = UINib(nibName: "NetworkConnectionErrorView", bundle: nil)

        guard
            let view = nib.instantiate(withOwner: nil,
                                         options: nil).first as? NetworkConnectionErrorView
            else {
                return nil
        }

        view.latestUpdateLabelHeightConstraint?.constant = 0
        view.dateLatestUpdateLabelHeightConstraint?.constant = 0

        return view
    }

    // MARK: - Private Properties
    // MARK: -- Outlets
    @IBOutlet private weak var latestUpdateLabel: UILabel?
    @IBOutlet private weak var dateLatestUpdateLabel: UILabel?
    // MARK: -- Constraints
    @IBOutlet private weak var latestUpdateLabelHeightConstraint: NSLayoutConstraint?
    @IBOutlet private weak var dateLatestUpdateLabelHeightConstraint: NSLayoutConstraint?

    // MARK: - Public Methods
    // MARK: -- Configure UI
    func setDateLatestUpdate(_ date: String) {

        // update UI
        self.latestUpdateLabelHeightConstraint?.constant = 30
        self.dateLatestUpdateLabelHeightConstraint?.constant = 30

        self.layoutIfNeeded()

        // setup date latest update
        self.dateLatestUpdateLabel?.text = date
    }

}
