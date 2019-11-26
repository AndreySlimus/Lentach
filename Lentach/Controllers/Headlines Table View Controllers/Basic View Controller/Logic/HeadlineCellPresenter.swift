//
//  HeadlineCellPresenter.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//

import UIKit

class HeadlineCellPresenter {

    // MARK: - Static Methods
    // MARK: -- Public 
    static func createViewModel(headline: Headline,
                                completionHandler: @escaping(HeadlineCellViewModel?) -> Void) {

        var author, date: String?, viewModel: HeadlineCellViewModel?

        if let imageAuthor = headline.imageMetadata?.author {
            if HTMLDecoder.isContainHTML(imageAuthor) {
                author = HTMLDecoder.removeHTML(imageAuthor)
            } else {
                author = imageAuthor
            }
        }

        if let modified = headline.info?.modified {
            date = DatePreparer.dateStringSince1970(modified)
        }

        if let url = headline.imageMetadata?.url {

            ImagesProvider.image(url: url) { loadedImage in

                viewModel = HeadlineCellViewModel.init(picture: loadedImage,
                                                       title: headline.info?.title,
                                                       description: headline.info?.rightcol,
                                                       author: author,
                                                       date: date)

                completionHandler(viewModel)
            }

        } else {

            viewModel = HeadlineCellViewModel.init(picture: nil,
                                                   title: headline.info?.title,
                                                   description: headline.info?.rightcol,
                                                   author: author,
                                                   date: date)

            completionHandler(viewModel)
        }
    }

}
