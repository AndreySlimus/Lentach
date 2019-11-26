//
//  NewsTextContentView.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//

import UIKit

final class NewsTextContentView: UIView {

    // MARK: - Constants
    private struct Constants {

        static let standardLeftSpacing: CGFloat = 15
        static let standardRightSpacing: CGFloat  = -15
    }

    // MARK: - Private Properties
    // MARK: -- UI Properties
    private var textLabel = LentachLabel.init(frame: CGRect.zero, fontSize: 18)

    // MARK: - Lifecycle
    // MARK: -- Initializations
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupTextLabel()

        settings()
    }

    // MARK: - Private Methods
    // MARK: -- Setup UI
    fileprivate func setupTextLabel() {

        self.textLabel.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(self.textLabel)

        NSLayoutConstraint.activate([
            self.textLabel.topAnchor.constraint(equalTo: self.topAnchor,
                                                constant: +30),
            self.textLabel.leftAnchor.constraint(equalTo: self.leftAnchor,
                                                 constant: Constants.standardLeftSpacing),
            self.textLabel.rightAnchor.constraint(equalTo: self.rightAnchor,
                                                  constant: Constants.standardRightSpacing),
            self.textLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor,
                                                   constant: -20)
        ])
    }

    // MARK: -- Settings UI
    fileprivate func settings() {

        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    // MARK: -- Configure UI
    func configure(_ viewModel: NewsTextContentViewModel) {

        self.textLabel.text = viewModel.text

        self.layoutIfNeeded()
    }

}
