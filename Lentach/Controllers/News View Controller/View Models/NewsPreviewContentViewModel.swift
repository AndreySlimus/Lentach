//
//  NewsPreviewContentViewModel.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//

import UIKit

class NewsPreviewContentViewModel {

    private(set) var date: String?
    private(set) var title: String?
    private(set) var announce: String?

    init(dateString: String?, title: String?, announce: String?) {

        self.date = dateString
        self.title = title
        self.announce = announce
    }

}
