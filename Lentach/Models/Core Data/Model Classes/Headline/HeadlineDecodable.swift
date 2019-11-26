//
//  HeadlineDecodable.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation
import CoreData

extension Headline: Decodable {

    enum CodingKeys: String, CodingKey {
        case type
        case info
        case URLs = "links"
        case imageMetadata = "title_image"
    }

    // MARK: - Lifecycle
    // MARK: -- Initializations
    convenience public init(from decoder: Decoder) throws {

        guard
            let codingUserInfoContext = CodingUserInfoKey.context,
            let context = decoder.userInfo[codingUserInfoContext] as? NSManagedObjectContext
            else {
                throw CoreDataInitializationErrors.noContext
        }

        guard let entity = NSEntityDescription.entity(forEntityName: "Headline", in: context) else {
            throw CoreDataInitializationErrors.noEntity
        }

        self.init(entity: entity, insertInto: context)

        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.info = try container.decodeIfPresent(HeadlineInfo.self, forKey: .info)
        self.urls = try container.decodeIfPresent(HeadlineURLs.self, forKey: .URLs)
        self.imageMetadata = try container.decodeIfPresent(HeadlineImageMetadata.self, forKey: .imageMetadata)
        self.type = try container.decode(Headline.Types.self, forKey: .type).rawValue

        if let codingUserInfoCategory = CodingUserInfoKey.type,
           let category = decoder.userInfo[codingUserInfoCategory] as? Headline.Category {

            self.category = category.rawValue
        }

        if let codingUserInfoNews = CodingUserInfoKey.news,
           let news = decoder.userInfo[codingUserInfoNews] as? News {

            news.addToAssociatedHeadlines(self)
        }
    }

}
