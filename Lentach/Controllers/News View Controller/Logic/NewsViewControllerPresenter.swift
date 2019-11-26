//
//  NewsViewControllerPresenter.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation

class NewsViewControllerPresenter {

    // MARK: - Static Methods
    // MARK: -- Public
    static func createNewsImageInfoViewModel(headline: Headline,
                                             completionHandler: @escaping(NewsImageInfoViewModel) -> Void) {

        var author, caption: String?

        if let imageAuthor = headline.imageMetadata?.author {
            if HTMLDecoder.isContainHTML(imageAuthor) {
                author = HTMLDecoder.removeHTML(imageAuthor)
            } else {
                author = imageAuthor
            }
        }

        if let imageCaption = headline.imageMetadata?.caption {
            if HTMLDecoder.isContainHTML(imageCaption) {
                caption = HTMLDecoder.removeHTML(imageCaption)
            } else {
                caption = imageCaption
            }
        }

        if let url = headline.imageMetadata?.url {
            ImagesProvider.image(url: url) { image in
                let viewModel = NewsImageInfoViewModel.init(image: image,
                                                            imageAuthor: author,
                                                            caption: caption)
                completionHandler(viewModel)
            }
        } else {
            let viewModel = NewsImageInfoViewModel.init(image: nil,
                                                        imageAuthor: author,
                                                        caption: caption)
            completionHandler(viewModel)
        }
    }

    static func createNewsPreviewContentViewModel(headline: Headline) -> NewsPreviewContentViewModel {

        var date: String?

        if let modified = headline.info?.modified {
           date = DatePreparer.dateStringSince1970(modified)
        }

        let viewModel = NewsPreviewContentViewModel.init(dateString: date,
                                                        title: headline.info?.title,
                                                        announce: headline.info?.rightcol)
        return viewModel
    }

    static func createNewsTextContentViewModel(news: News) -> NewsTextContentViewModel {

        let viewModel = NewsTextContentViewModel.init(text: news.text)

        return viewModel
    }

    static func createPreviewVideoViewModel(news: News,
                                            completionHandler: @escaping(PreviewVideoViewModel) -> Void) {

        if let url = news.video?.imageURL {
            ImagesProvider.image(url: url) { image in
                let viewModel = PreviewVideoViewModel.init(previewImage: image,
                                                           description: news.video?.title)
                completionHandler(viewModel)
            }
        } else {
            let viewModel = PreviewVideoViewModel.init(previewImage: nil,
                                                       description: news.video?.title)
            completionHandler(viewModel)
        }
    }

}
