//
//  HeadlineCellViewModel.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//

import UIKit

class HeadlineCellViewModel {

    private(set) var picture: UIImage?
    private(set) var title: String?
    private(set) var description: String?
    private(set) var author: String?
    private(set) var date: String?

    init (picture: UIImage?, title: String?, description: String?, author: String?, date: String?) {

        self.picture = picture
        self.title = title
        self.description = description
        self.author = author
        self.date = date
    }

}
