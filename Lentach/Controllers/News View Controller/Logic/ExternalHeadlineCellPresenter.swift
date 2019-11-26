//
//  ExternalHeadlineCellPresenter.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation

class ExternalHeadlineCellPresenter {

    // MARK: - Static Methods
    // MARK: -- Public
    static func createViewModel(headline: Headline) -> ExternalHeadlineCellViewModel {

        var date: String?

        if let modified = headline.info?.modified {
            date = DatePreparer.dateStringSince1970(modified)
        }

        let viewModel = ExternalHeadlineCellViewModel.init(site: headline.urls?.external?.absoluteString.siteAddress,
                                                           date: date,
                                                           title: headline.info?.title,
                                                           description: headline.info?.rightcol)

        return viewModel
    }
}
