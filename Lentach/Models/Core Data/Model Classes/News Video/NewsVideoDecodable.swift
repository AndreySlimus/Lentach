//
//  NewsVideoDecodable.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation
import CoreData

extension NewsVideo: Decodable {

    enum CodingKeys: String, CodingKey {
        case title = "caption"
        case watchURL = "watch_url"
        case imageURL = "preview_image_url"
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

        guard let entity = NSEntityDescription.entity(forEntityName: "NewsVideo", in: context) else {
            throw CoreDataInitializationErrors.noEntity
        }

        self.init(entity: entity, insertInto: context)

        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.watchURL = try container.decodeIfPresent(URL.self, forKey: .watchURL)
        self.imageURL = try container.decodeIfPresent(URL.self, forKey: .imageURL)

        if let codingUserInfoNews = CodingUserInfoKey.news,
           let news = decoder.userInfo[codingUserInfoNews] as? News {

            self.news = news
        }
    }

}
