//
//  NewsImageInfoViewModel.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//

import UIKit

class NewsImageInfoViewModel {

    private(set) var image: UIImage?
    private(set) var imageAuthor: String?
    private(set) var caption: String?

    init(image: UIImage?, imageAuthor: String?, caption: String?) {

        self.image = image
        self.imageAuthor = imageAuthor
        self.caption = caption
    }

}
