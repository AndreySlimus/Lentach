//
//  HeadlineCell.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//

import UIKit

class HeadlineCell: UITableViewCell {

    // MARK: - Static Properties
    // MARK: -- Public
    static let reuseIdentifier = "HeadlineCell"
    static let standardHeight: CGFloat = 250

    // MARK: - Private Properties
    // MARK: -- IBOutlets
    @IBOutlet private var pictureView: UIImageView?
    @IBOutlet private var titleLabel: UILabel?
    @IBOutlet private var descriptionLabel: UILabel?
    @IBOutlet private var authorLabel: UILabel?
    @IBOutlet private var dateLabel: UILabel?
    @IBOutlet private var loadingEffectViews: [UIView]?
    @IBOutlet private var loadingEffectView: LoadingEffectView?
    @IBOutlet private var animatedViews: [UIView]?

    // MARK: - Lifecycle
    // MARK: -- View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()

        self.pictureView?.image = nil
        self.titleLabel?.text = nil
        self.descriptionLabel?.text = nil
        self.dateLabel?.text = nil
        self.authorLabel?.text = nil

        guard
            let loadingEffectView = self.loadingEffectView,
            let loadingEffectViews = self.loadingEffectViews
            else {
                return
        }

        loadingEffectView.addRoundedLayers(loadingEffectViews)
        loadingEffectView.startAnimating()
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        prepareCellForReuse()
    }

    // MARK: - Private Methods
    // MARK: -- Settings UI
    private func prepareCellForReuse() {

        self.pictureView?.image = nil
        self.titleLabel?.text = nil
        self.descriptionLabel?.text = nil
        self.dateLabel?.text = nil
        self.authorLabel?.text = nil

        self.loadingEffectView?.stopAnimating()

        self.animatedViews?.forEach { view in
            view.layer.removeAllAnimations()
        }

        self.layer.removeAllAnimations()

        self.loadingEffectView?.isHidden = false
        self.loadingEffectView?.startAnimating()

    }

    // MARK: -- Configure UI
    func configure(_ viewModel: HeadlineCellViewModel) {

        UIView.transition(with: self,
                          duration: 0.3,
                          options: .allowUserInteraction,
                          animations: {
                            self.loadingEffectView?.isHidden = true
        }, completion: { _ in

            self.loadingEffectView?.stopAnimating()

            UIView.transition(with: self,
                              duration: 0.3,
                              options: .allowUserInteraction,
                              animations: {
                                self.pictureView?.image = viewModel.picture
                                self.titleLabel?.text = viewModel.title
                                self.descriptionLabel?.text = viewModel.description
                                self.dateLabel?.text = viewModel.date
                                self.authorLabel?.text = viewModel.author
            }, completion: nil )
        })
    }

}
