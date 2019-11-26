//
//  HeadlineImageMetadataDecodable.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation
import CoreData

extension HeadlineImageMetadata: Decodable {

    enum CodingKeys: String, CodingKey {
        case author = "credits"
        case caption
        case url
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

        guard
            let entity = NSEntityDescription.entity(forEntityName: "HeadlineImageMetadata",
                                                      in: context)
            else {
            throw CoreDataInitializationErrors.noEntity
        }

        self.init(entity: entity, insertInto: context)

        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.author = try container.decodeIfPresent(String.self, forKey: .author)
        self.caption = try container.decodeIfPresent(String.self, forKey: .caption)
        self.url = try container.decodeIfPresent(URL.self, forKey: .url)
    }

}
