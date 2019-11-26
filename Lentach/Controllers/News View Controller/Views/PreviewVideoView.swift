//
//  VideoPreviewView.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//

import UIKit

protocol PreviewVideoViewDelegate: class {

    func didTapPlayButton(_ previewVideoView: PreviewVideoView)
}

class PreviewVideoView: UIView {

    // MARK: - Constants
    private struct Constants {

        static let standardVerticalSpacing: CGFloat  = +20
        static let standardLeftSpacing: CGFloat = +15
        static let standardRightSpacing: CGFloat  = -15
    }

    // MARK: - Delegate
    weak var delegate: PreviewVideoViewDelegate?

    // MARK: - Private Properties
    // MARK: -- UI Properties
    private var previewImageView = NewsImageView.init(frame: CGRect.zero)
    private var alphaView = UIView.init(frame: CGRect.zero)
    private var playButton = UIButton.init(type: .custom)
    private var descriptionLabel = LentachLabel.init(frame: CGRect.zero, fontSize: 18, textColor: .white)
    private var separatorLineView = UIView.init(frame: CGRect.zero)

    // MARK: - Lifecycle
    // MARK: -- Initializations
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupPreviewImageView()
        setupAlphaView()
        setupPlayButton()
        setupDescriptionLabel()
        setupSeparatorLineView()

        settings()
    }

    // MARK: - Private Methods
    // MARK: -- Setup UI
    fileprivate func setupPreviewImageView() {

        self.previewImageView.translatesAutoresizingMaskIntoConstraints = false
        self.previewImageView.clipsToBounds = true
        self.previewImageView.contentMode = .scaleToFill
        self.previewImageView.isUserInteractionEnabled = true

        self.addSubview(self.previewImageView)

        NSLayoutConstraint.activate([
            self.previewImageView.heightAnchor.constraint(equalToConstant: 200),
            self.previewImageView.topAnchor.constraint(equalTo: self.topAnchor,
                                                       constant: Constants.standardVerticalSpacing),
            self.previewImageView.leftAnchor.constraint(equalTo: self.leftAnchor,
                                                        constant: Constants.standardLeftSpacing),
            self.previewImageView.rightAnchor.constraint(equalTo: self.rightAnchor,
                                                         constant: Constants.standardRightSpacing)
        ])
    }

    fileprivate func setupAlphaView() {

        self.alphaView.frame = self.previewImageView.frame

        self.alphaView.translatesAutoresizingMaskIntoConstraints = false
        self.alphaView.isUserInteractionEnabled = true
        self.alphaView.backgroundColor = .lentachGray
        self.alphaView.alpha = 0.3

        self.previewImageView.addSubview(self.alphaView)

        NSLayoutConstraint.activate([
            self.alphaView.topAnchor.constraint(equalTo: self.previewImageView.topAnchor),
            self.alphaView.leftAnchor.constraint(equalTo: self.previewImageView.leftAnchor),
            self.alphaView.rightAnchor.constraint(equalTo: self.previewImageView.rightAnchor),
            self.alphaView.bottomAnchor.constraint(equalTo: self.previewImageView.bottomAnchor)
        ])
    }

    fileprivate func setupPlayButton() {

        self.playButton.frame = CGRect.zero
        self.playButton.translatesAutoresizingMaskIntoConstraints = false
        self.playButton.isUserInteractionEnabled = true

        let normalPlay = UIImage.init(named: "normalPlay")
        self.playButton.setImage(normalPlay, for: .normal)

        let selectedPlay = UIImage.init(named: "selectedPlay")
        self.playButton.setImage(selectedPlay, for: .selected)

        self.playButton.addTarget(self,
                                  action: #selector(didTapPlayButton),
                                  for: .touchUpInside)

        self.previewImageView.addSubview(self.playButton)

        NSLayoutConstraint.activate([
            self.playButton.heightAnchor.constraint(equalToConstant: 50),
            self.playButton.widthAnchor.constraint(equalToConstant: 50),
            self.playButton.centerXAnchor.constraint(equalTo: self.previewImageView.centerXAnchor),
            self.playButton.centerYAnchor.constraint(equalTo: self.previewImageView.centerYAnchor)
        ])
    }

    private func setupDescriptionLabel() {

        self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(self.descriptionLabel)

        NSLayoutConstraint.activate([
            self.descriptionLabel.topAnchor.constraint(equalTo: self.previewImageView.bottomAnchor,
                                                       constant: Constants.standardVerticalSpacing),
            self.descriptionLabel.leftAnchor.constraint(equalTo: self.leftAnchor,
                                                        constant: Constants.standardLeftSpacing),
            self.descriptionLabel.rightAnchor.constraint(equalTo: self.rightAnchor,
                                                         constant: Constants.standardRightSpacing)
            ])
    }

    fileprivate func setupSeparatorLineView() {

        self.separatorLineView.translatesAutoresizingMaskIntoConstraints = false
        self.separatorLineView.backgroundColor = .white

        self.addSubview(self.separatorLineView)

        NSLayoutConstraint.activate([
            self.separatorLineView.heightAnchor.constraint(equalToConstant: 1),
            self.separatorLineView.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor,
                                                        constant: Constants.standardVerticalSpacing),
            self.separatorLineView.leftAnchor.constraint(equalTo: self.leftAnchor,
                                                         constant: Constants.standardLeftSpacing),
            self.separatorLineView.rightAnchor.constraint(equalTo: self.rightAnchor,
                                                          constant: Constants.standardRightSpacing),
            self.separatorLineView.bottomAnchor.constraint(equalTo: self.bottomAnchor,
                                                           constant: -20)
        ])
    }

    // MARK: -- Settings UI
    fileprivate func settings() {

        self.backgroundColor = .lentachGray
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isUserInteractionEnabled = true
    }

    // MARK: -- Configure UI
    func configure(_ viewModel: PreviewVideoViewModel) {

        self.previewImageView.image = viewModel.previewImage
        self.descriptionLabel.text = viewModel.description

        self.isHidden = false

        self.layoutIfNeeded()
    }

    // MARK: -- Actions UI
    @objc private func didTapPlayButton() {

        self.delegate?.didTapPlayButton(self)
    }

}
