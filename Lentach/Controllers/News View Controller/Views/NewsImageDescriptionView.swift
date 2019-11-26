//
//  NewsImageDescriptionView.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//

import UIKit

final class NewsImageDescriptionView: UIView {

    // MARK: - Constants
    private struct Constants {

        static let standardFontSize: CGFloat = 12
        static let standardFontColor = UIColor.white
        static let leftSpacing: CGFloat = 15
        static let rightSpacing: CGFloat  = -15
    }

    // MARK: - Private Properties
    // MARK: -- UI Properties
    private var authorLabel = LentachLabel.init(frame: CGRect.zero,
                                                fontSize: Constants.standardFontSize,
                                                textColor: .white)
    private lazy var descriptionLabel: LentachLabel = {
        var descriptionLabel = LentachLabel.init(frame: CGRect.zero,
                                                 fontSize: Constants.standardFontSize,
                                                 textColor: .white)
        return descriptionLabel
    }()

    // MARK: - Lifecycle
    // MARK: -- Initializations
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupAuthorLabel()

        settings()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - Public Methods
    // MARK: -- Configure UI
    func configure(author: String?, description: String?) {

        setAuthor(author)
        setDescription(description)
    }

    // MARK: - Private Methods
    // MARK: -- Setup UI
    fileprivate func setupAuthorLabel() {

        self.authorLabel.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(self.authorLabel)

        NSLayoutConstraint.activate([
            self.authorLabel.heightAnchor.constraint(equalToConstant: 20),
            self.authorLabel.leftAnchor.constraint(equalTo: self.leftAnchor,
                                                   constant: Constants.leftSpacing),
            self.authorLabel.rightAnchor.constraint(equalTo: self.rightAnchor,
                                                    constant: Constants.rightSpacing),
            self.authorLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    fileprivate func setupDescriptionLabel() {

        self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.descriptionLabel.isHidden = true

        self.addSubview(self.descriptionLabel)

        NSLayoutConstraint.activate([
            self.descriptionLabel.topAnchor.constraint(equalTo: self.topAnchor),
            self.descriptionLabel.leftAnchor.constraint(equalTo: self.leftAnchor,
                                                         constant: Constants.leftSpacing),
            self.descriptionLabel.rightAnchor.constraint(equalTo: self.rightAnchor,
                                                          constant: Constants.rightSpacing),
            self.descriptionLabel.bottomAnchor.constraint(equalTo: self.authorLabel.topAnchor)
        ])
    }

    // MARK: -- Settings UI
    private func settings() {

        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.lentachGray.withAlphaComponent(0.3)
    }

    // MARK: -- Configure UI
    private func setAuthor(_ text: String?) {

        guard let author = text else {
            self.authorLabel.text = "no author"
            return
        }

        self.authorLabel.text = author
    }

    private func setDescription(_ text: String?) {

        setupDescriptionLabel()

        self.descriptionLabel.text = text
        self.descriptionLabel.isHidden = false
    }

}
