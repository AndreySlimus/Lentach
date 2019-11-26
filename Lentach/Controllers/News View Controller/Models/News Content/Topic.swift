//
//  Topic.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation

final class Topic: Decodable {

    // MARK: - Public Properties
    // MARK: -- Model Properties
    let headline: TopicHeadline?
    let contents: [Content]?
    let associatedHeadlines: [Headline]?

    enum CodingKeys: String, CodingKey {
        case headline
        case contents = "body"
        case thematicHeadlines = "box_link"
    }

    // MARK: - Lifecycle
    // MARK: -- Initializations
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.headline = try container.decodeIfPresent(TopicHeadline.self, forKey: .headline)
        self.contents = try container.decodeIfPresent([Content].self, forKey: .contents)
        self.associatedHeadlines = try container.decodeIfPresent([Headline].self, forKey: .thematicHeadlines)
    }

}

extension Topic {

    // MARK: - Public Properties
    var text: String? {

        guard let contents = self.contents else {
            return nil
        }

        var text = String()

        let numberOfParagraphs = self.numberOfContentsWithType(.paragraph)
        var numberOfIterations = 0

        for content in contents {

            if let contentData = content.data {

                switch contentData {
                case .video, .another: break
                case .text(var contentText):

                    if HTMLDecoder.isContainHTML(contentText) {
                        contentText = HTMLDecoder.removeHTML(contentText)
                    }

                    if numberOfIterations != numberOfParagraphs {
                        text += contentText + String.paragraphSeparator
                    } else {
                        text += contentText
                    }

                    numberOfIterations += 1
                }
            }
        }

        return text
    }

    var previewVideoImageURL: URL? {

        if let content = self.contents?.first(where: {$0.imageURL != nil}) {
            return content.imageURL
        } else {
            return nil
        }
    }

    // MARK: - Public Methods
    func numberOfContentsWithType(_ type: Content.Types) -> Int {

        guard let contents = self.contents else { return 0 }

        return contents.filter {$0.type == type}.count - 1
    }

}
