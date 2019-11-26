//
//  NewsContentScrollView.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//

import UIKit

class NewsContentScrollView: UIScrollView {

    // MARK: - Private Properties
    // MARK: -- UI Properties
    private var contentView = UIView()
    private var imageContainerView = UIView()
    private var previewContainerView = UIView()
    private var textContainerView = UIView()
    private var videoContainerView = UIView()
    private var tableContainerView = UIView()

    var heightOfContentView: CGFloat {
        return self.contentView.frame.height
    }

    // MARK: - Lifecycle
    // MARK: -- Initializations
    override init(frame: CGRect) {
        super.init(frame: frame)

        settings()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - Public Methods
    func setupViews() {

        setupContentView()
        setupImageContainerView()
        setupPreviewContainerView()
        setupTextContainerView()
        setupVideoContainerView()
        setupTableContainerView()

        updateHeightContentView()
    }

    enum ContainerViewsTypes {
        case image, preview, text, video, table
    }

    func add(view: UIView, toContainerWithType type: ContainerViewsTypes) {

        switch type {
        case .image:    self.imageContainerView.addContainerSubview(view)
        case .preview:  self.previewContainerView.addContainerSubview(view)
        case .text:     self.textContainerView.addContainerSubview(view)
        case .video:    self.videoContainerView.addContainerSubview(view)
        case .table:    self.tableContainerView.addContainerSubview(view)
        }
    }

    func updateHeightContentView() {

        self.layoutIfNeeded()
        self.contentSize.height = self.tableContainerView.frame.maxY
    }

    func changeBackgroundColor(_ color: UIColor = UIColor.lentachGray) {

        self.backgroundColor = color
    }

    // MARK: - Private Methods
    // MARK: -- Setup UI
    fileprivate func setupContentView() {

        self.contentView.frame = CGRect.zero
        self.contentView.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(self.contentView)

        NSLayoutConstraint.activate([
            self.contentView.widthAnchor.constraint(equalTo: self.widthAnchor),
            self.contentView.topAnchor.constraint(equalTo: self.topAnchor),
            self.contentView.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.contentView.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    fileprivate func setupImageContainerView() {

        self.imageContainerView.frame = CGRect.zero
        self.imageContainerView.translatesAutoresizingMaskIntoConstraints = false

        self.contentView.addSubview(self.imageContainerView)

        if let superview = self.superview {

            let equalTopAnchor = self.imageContainerView.topAnchor.constraint(equalTo: superview.topAnchor)
            equalTopAnchor.priority = UILayoutPriority.init(750)
            equalTopAnchor.isActive = true

            let lessThanOrEqualTopAnchor = self.imageContainerView.topAnchor.constraint(lessThanOrEqualTo: superview.topAnchor)
            lessThanOrEqualTopAnchor.isActive = true

        } else {

            self.imageContainerView.topAnchor.constraint(lessThanOrEqualTo: self.topAnchor).isActive = true
        }

        NSLayoutConstraint.activate([
            self.imageContainerView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.imageContainerView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor)
        ])
    }

    fileprivate func setupPreviewContainerView() {

        self.previewContainerView.frame = CGRect.zero
        self.previewContainerView.translatesAutoresizingMaskIntoConstraints = false

        self.contentView.addSubview(self.previewContainerView)

        NSLayoutConstraint.activate([
            self.previewContainerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: +250),
            self.previewContainerView.topAnchor.constraint(equalTo: self.imageContainerView.bottomAnchor),
            self.previewContainerView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.previewContainerView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor)
        ])
    }

    fileprivate func setupTextContainerView() {

        self.textContainerView.frame = CGRect.zero
        self.textContainerView.translatesAutoresizingMaskIntoConstraints = false

        self.contentView.addSubview(self.textContainerView)

        NSLayoutConstraint.activate([
            self.textContainerView.topAnchor.constraint(equalTo: self.previewContainerView.bottomAnchor),
            self.textContainerView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.textContainerView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor)
        ])
    }

    fileprivate func setupVideoContainerView() {

        self.videoContainerView.frame = CGRect.zero
        self.videoContainerView.translatesAutoresizingMaskIntoConstraints = false

        self.contentView.addSubview(self.videoContainerView)

        NSLayoutConstraint.activate([
            self.videoContainerView.topAnchor.constraint(equalTo: self.textContainerView.bottomAnchor),
            self.videoContainerView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.videoContainerView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor)
        ])
    }

    fileprivate func setupTableContainerView() {

        self.tableContainerView.frame = CGRect.zero
        self.tableContainerView.translatesAutoresizingMaskIntoConstraints = false

        self.contentView.addSubview(self.tableContainerView)

        NSLayoutConstraint.activate([
            self.tableContainerView.topAnchor.constraint(equalTo: self.videoContainerView.bottomAnchor),
            self.tableContainerView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.tableContainerView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            self.tableContainerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }

    // MARK: -- Settings UI
    private func settings() {

        self.scrollIndicatorInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        self.contentInsetAdjustmentBehavior = .never
        self.backgroundColor = .white
    }

}
