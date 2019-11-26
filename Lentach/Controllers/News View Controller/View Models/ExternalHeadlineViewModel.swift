//
//  ExternalHeadlineViewModel.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//

import UIKit

class ExternalHeadlineCellViewModel {

    private(set) var site: String?
    private(set) var date: String?
    private(set) var title: String?
    private(set) var description: String?

    init(site: String?, date: String?, title: String?, description: String?) {

        self.site = site
        self.date = date
        self.title = title
        self.description = description
    }

}
