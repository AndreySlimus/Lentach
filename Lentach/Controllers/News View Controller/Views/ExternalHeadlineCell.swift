//
//  ExternalHeadlineCell.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//

import UIKit

class ExternalHeadlineCell: UITableViewCell {

    // MARK: - Static Properties
    // MARK: -- Public
    static let reuseIdentifier = "ExternalHeadlineCell"
    static let standardHeight: CGFloat = 150

    // MARK: - Constants
    private struct Constants {

        static let standardLeftSpacing: CGFloat = +15
        static let standardRightSpacing: CGFloat = -15
        static let standardVerticalSpacing: CGFloat = 8
        static let standardVerticalSpacingFromBottom: CGFloat = -8
        static let standardElementHeight: CGFloat = 17.5
    }

    // MARK: - Private Properties
    // MARK: -- UI Properties
    private var titleLabel = LentachLabel.init(frame: CGRect.zero, fontSize: 18, textColor: .white)
    private var descriptionLabel = LentachLabel.init(frame: CGRect.zero, fontSize: 17, textColor: .white)
    private var URLLabel = LentachLabel.init(frame: CGRect.zero, fontSize: 15, textColor: .white)
    private var dateLabel = LentachLabel.init(frame: CGRect.zero, fontSize: 15, textColor: .white)
    private var URLImageView = UIImageView()

    // MARK: - Lifecycle
    // MARK: -- Initializations
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupTitleLabel()
        setupDescriptionLabel()
        setupURLImageView()
        setupURLLabel()
        setupDateLabel()

        settings()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - Private Methods
    // MARK: -- Setup UI
    private func setupTitleLabel() {

        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(self.titleLabel)

        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor,
                                                 constant: Constants.standardVerticalSpacing),
            self.titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor,
                                                  constant: Constants.standardLeftSpacing),
            self.titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor,
                                                   constant: Constants.standardRightSpacing)
        ])
    }

    private func setupDescriptionLabel() {

        self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(self.descriptionLabel)

        NSLayoutConstraint.activate([
            self.descriptionLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor,
                                                       constant: Constants.standardVerticalSpacing),
            self.descriptionLabel.leftAnchor.constraint(equalTo: self.leftAnchor,
                                                        constant: Constants.standardLeftSpacing),
            self.descriptionLabel.rightAnchor.constraint(equalTo: self.rightAnchor,
                                                         constant: Constants.standardRightSpacing)
        ])
    }

    private func setupURLImageView() {

        self.URLImageView = UIImageView.init(frame: CGRect.zero)

        self.URLImageView.translatesAutoresizingMaskIntoConstraints = false
        self.URLImageView.contentMode = .scaleAspectFit
        self.URLImageView.image = UIImage.init(named: "link.png")

        self.addSubview(self.URLImageView)

        NSLayoutConstraint.activate([
            self.URLImageView.heightAnchor.constraint(equalToConstant: Constants.standardElementHeight),
            self.URLImageView.widthAnchor.constraint(equalToConstant: Constants.standardElementHeight),
            self.URLImageView.leftAnchor.constraint(equalTo: self.leftAnchor,
                                                    constant: Constants.standardLeftSpacing),
            self.URLImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor,
                                                      constant: Constants.standardVerticalSpacingFromBottom)
        ])
    }

    private func setupURLLabel() {

        self.URLLabel.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(self.URLLabel)

        NSLayoutConstraint.activate([
            self.URLLabel.heightAnchor.constraint(equalToConstant: Constants.standardElementHeight),
            self.URLLabel.leftAnchor.constraint(equalTo: self.URLImageView.rightAnchor,
                                                constant: Constants.standardLeftSpacing),
            self.URLLabel.rightAnchor.constraint(equalTo: self.rightAnchor,
                                                 constant: Constants.standardRightSpacing),
            self.URLLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor,
                                                  constant: Constants.standardVerticalSpacingFromBottom)
        ])
    }

    private func setupDateLabel() {

        self.dateLabel.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(self.dateLabel)

        NSLayoutConstraint.activate([
            self.dateLabel.heightAnchor.constraint(equalToConstant: Constants.standardElementHeight),
            self.dateLabel.leftAnchor.constraint(equalTo: self.leftAnchor,
                                                 constant: Constants.standardLeftSpacing),
            self.dateLabel.rightAnchor.constraint(equalTo: self.rightAnchor,
                                                  constant: Constants.standardRightSpacing),
            self.dateLabel.bottomAnchor.constraint(equalTo: self.URLLabel.topAnchor,
                                                   constant: Constants.standardVerticalSpacingFromBottom)
            ])
    }

    // MARK: -- Settings UI
    private func settings() {

        self.backgroundColor = .lentachGray
        self.selectionStyle = .none
        self.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }

    // MARK: -- Configure UI
    func configure(_ viewModel: ExternalHeadlineCellViewModel) {

        self.titleLabel.text = viewModel.title
        self.descriptionLabel.text = viewModel.description
        self.dateLabel.text = viewModel.date
        self.URLLabel.text = viewModel.site
    }

}
