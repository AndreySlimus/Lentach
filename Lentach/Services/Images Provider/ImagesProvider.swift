//
//  ImagesProvider.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//

import UIKit

class ImagesProvider {

    // MARK: - Static Functions
    static func image(url: URL, completionHandler: @escaping(UIImage?) -> Void) {

        if let image = ImagesCache.load(url.absoluteString) {
            completionHandler(image)
            return
        } else if let image = ImagesFileManager.load(atPath: url.absoluteString) {
            completionHandler(image)
            return
        } else {
            Network.loadImage(url: url) { response in

                switch response {
                case .success(let image):
                    ImagesFileManager.save(image, atPath: url.absoluteString)
                    ImagesCache.save(image, atPath: url.absoluteString)

                    completionHandler(image)
                    return
                case .failure:
                    completionHandler(nil)
                    return
                }
            }
        }
    }

}
