//
//  ImageCache.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//

import UIKit

class ImagesCache {

    // MARK: - Private Static Properties
    private static let cache = NSCache<NSString, UIImage>()

    // MARK: - Public Static Functions
    static func save(_ image: UIImage, atPath path: String) {

        self.cache.setObject(image, forKey: path.createPath as NSString)
    }

    static func load(_ path: String) -> UIImage? {
        return self.cache.object(forKey: path.createPath as NSString)
    }

}
