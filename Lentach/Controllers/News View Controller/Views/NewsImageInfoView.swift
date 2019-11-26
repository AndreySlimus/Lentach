//
//  NewsImageInfoView.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//

import UIKit

class NewsImageInfoView: UIView {

    // MARK: - Constants
    private struct Constants {

        static let standardImageViewHeight: CGFloat = 250
    }

    // MARK: - Private Properties
    // MARK: -- UI Properties
    private var imageView = NewsImageView()
    private var imageDescriptionView = NewsImageDescriptionView()

    // MARK: - Lifecycle
    // MARK: -- Initializations
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupImageView()
        setupImageDescriptionView()

        settings()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - Private Methods
    // MARK: -- Setup UI
    fileprivate func setupImageView() {

        self.imageView.clipsToBounds = true
        self.imageView.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(self.imageView)

        NSLayoutConstraint.activate([
            self.imageView.heightAnchor.constraint(greaterThanOrEqualToConstant: Constants.standardImageViewHeight),
            self.imageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.imageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.imageView.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    fileprivate func setupImageDescriptionView() {

        self.imageDescriptionView.frame = CGRect.zero

        self.imageDescriptionView.translatesAutoresizingMaskIntoConstraints = false

        self.imageView.addSubview(self.imageDescriptionView)

        NSLayoutConstraint.activate([
            self.imageDescriptionView.leftAnchor.constraint(equalTo: self.imageView.leftAnchor),
            self.imageDescriptionView.rightAnchor.constraint(equalTo: self.imageView.rightAnchor),
            self.imageDescriptionView.bottomAnchor.constraint(equalTo: self.imageView.bottomAnchor)
        ])
    }

    // MARK: -- Settings UI
    fileprivate func settings() {

        self.translatesAutoresizingMaskIntoConstraints = false
    }

    // MARK: -- Configure UI
    func configure(_ viewModel: NewsImageInfoViewModel) {

        self.imageView.image = viewModel.image
        self.imageDescriptionView.configure(author: viewModel.imageAuthor, description: viewModel.caption)

        self.layoutIfNeeded()
    }

}
