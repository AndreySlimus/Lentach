//
//  ThematicHeadlinesTableView.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//

import UIKit

class AssociatedHeadlinesTableView: UITableView {

    // MARK: - Lifecycle
    // MARK: -- Initializations
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)

        settings()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - Private Methods
    // MARK: -- Settings UI
    fileprivate func settings() {

        self.register(UINib.init(nibName: "HeadlineCell",
                                 bundle: nil),
                      forCellReuseIdentifier: HeadlineCell.reuseIdentifier)
        self.register(ExternalHeadlineCell.self,
                      forCellReuseIdentifier: ExternalHeadlineCell.reuseIdentifier)

        self.isScrollEnabled = false
        self.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        self.separatorColor = .white

        self.tableHeaderView = AssociatedHeadlinesView.standardStyle()
    }

}
