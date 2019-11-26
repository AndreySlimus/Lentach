//
//  AssociatedHeadlinesView.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//

import UIKit

class AssociatedHeadlinesView: UIView {

    // MARK: - Class Methods
    class func standardStyle() -> AssociatedHeadlinesView {

        let associatedHeadlinesView = AssociatedHeadlinesView.init(frame: CGRect.init(x: 0,
                                                                                      y: 0,
                                                                                      width: 0,
                                                                                      height: AssociatedHeadlinesView.standardHeight))

        return associatedHeadlinesView
    }

    // MARK: - Static Properties
    // MARK: -- Public
    static let standardHeight: CGFloat = 50

    // MARK: - Private Properties
    // MARK: -- UI Properties
    private lazy var textLabel: LentachLabel = {
        let textLabel = LentachLabel.init(frame: CGRect.zero,
                                          fontSize: 25,
                                          textColor: .white)
        textLabel.text = "Похожие новости:"

        return textLabel
    }()

    // MARK: - Lifecycle
    // MARK: -- Initializations
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupTextLabel()

        settings()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - Private Methods
    // MARK: -- Setup UI
    private func setupTextLabel() {

        self.textLabel.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(textLabel)

        NSLayoutConstraint.activate([
            self.textLabel.topAnchor.constraint(equalTo: self.topAnchor),
            self.textLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: +15),
            self.textLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15),
            self.textLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    // MARK: -- Settings UI
    private func settings() {

        self.backgroundColor = .lentachGray
    }

}
