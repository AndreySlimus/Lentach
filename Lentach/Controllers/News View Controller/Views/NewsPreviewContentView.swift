//
//  NewsPreviewContentView.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//

import UIKit

final class NewsPreviewContentView: UIView {

    // MARK: - Constants
    private struct Constants {

        static let standardLeftSpacing: CGFloat = +15
        static let standardRightSpacing: CGFloat  = -15
        static let standardVerticalSpacing: CGFloat = +10
    }

    // MARK: - Private Properties
    // MARK: -- UI Properties
    private var dateLabel = LentachLabel.init(frame: CGRect.zero, fontSize: 12)
    private var titleLabel = LentachLabel.init(frame: CGRect.zero, fontSize: 25)
    private var titleSeparator = UIView.init(frame: CGRect.zero)
    private var announceLabel = LentachLabel.init(frame: CGRect.zero, fontSize: 18)

    // MARK: - Lifecycle
    // MARK: -- Initializations
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupDateLabel()
        setupTitleLabel()
        setupTitleSeparator()
        setupAnnounceLabel()

        settings()
    }

    // MARK: - Private Methods
    // MARK: -- Setup UI
    fileprivate func setupDateLabel() {

        self.dateLabel.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(self.dateLabel)

        NSLayoutConstraint.activate([
            self.dateLabel.topAnchor.constraint(equalTo: self.topAnchor,
                                                constant: +20),
            self.dateLabel.leftAnchor.constraint(equalTo: self.leftAnchor,
                                                 constant: Constants.standardLeftSpacing),
            self.dateLabel.rightAnchor.constraint(equalTo: self.rightAnchor,
                                                  constant: Constants.standardRightSpacing)
        ])
    }

    fileprivate func setupTitleLabel() {

        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(self.titleLabel)

        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.dateLabel.bottomAnchor,
                                                 constant: Constants.standardVerticalSpacing),
            self.titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor,
                                                  constant: Constants.standardLeftSpacing),
            self.titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor,
                                                   constant: Constants.standardRightSpacing)
        ])
    }

    fileprivate func setupTitleSeparator() {

        self.titleSeparator.translatesAutoresizingMaskIntoConstraints = false
        self.titleSeparator.backgroundColor = .lentachGray

        self.addSubview(self.titleSeparator)

        NSLayoutConstraint.activate([
            self.titleSeparator.heightAnchor.constraint(equalToConstant: 1),
            self.titleSeparator.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor,
                                                     constant: Constants.standardVerticalSpacing),
            self.titleSeparator.leftAnchor.constraint(equalTo: self.leftAnchor,
                                                      constant: Constants.standardLeftSpacing),
            self.titleSeparator.rightAnchor.constraint(equalTo: self.rightAnchor,
                                                       constant: Constants.standardRightSpacing)
        ])
    }

    fileprivate func setupAnnounceLabel() {

        self.announceLabel.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(self.announceLabel)

        NSLayoutConstraint.activate([
            self.announceLabel.topAnchor.constraint(equalTo: self.titleSeparator.bottomAnchor,
                                                    constant: Constants.standardVerticalSpacing),
            self.announceLabel.leftAnchor.constraint(equalTo: self.leftAnchor,
                                                     constant: Constants.standardLeftSpacing),
            self.announceLabel.rightAnchor.constraint(equalTo: self.rightAnchor,
                                                      constant: Constants.standardRightSpacing),
            self.announceLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    // MARK: -- Settings UI
    fileprivate func settings() {

        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    // MARK: -- Configure UI
    func configure(_ viewModel: NewsPreviewContentViewModel) {

        self.dateLabel.text = viewModel.date
        self.titleLabel.text = viewModel.title
        self.announceLabel.text = viewModel.announce

        self.layoutIfNeeded()
    }

}
