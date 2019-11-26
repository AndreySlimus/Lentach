//
//  NewsImageView.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//

import UIKit

class NewsImageView: UIImageView {

    // MARK: - Lifecycle
    // MARK: -- Initializations
    override init(frame: CGRect) {
        super.init(frame: frame)

        settings()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    convenience init() {

        self.init(frame: CGRect.zero)
    }

    // MARK: - Private Methods
    // MARK: -- Settings UI
    fileprivate func settings() {

        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
        self.backgroundColor = .lentachGray
    }

}
