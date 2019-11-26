//
//  PreviewVideoViewModel.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//

import UIKit

class PreviewVideoViewModel {

    private(set) var previewImage: UIImage?
    private(set) var description: String?

    init(previewImage: UIImage?, description: String?) {

        self.previewImage = previewImage
        self.description = description
    }

}
