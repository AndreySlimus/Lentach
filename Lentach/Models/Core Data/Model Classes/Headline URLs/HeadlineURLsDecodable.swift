//
//  HeadlineURLsDecodable.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation
import CoreData

extension HeadlineURLs: Decodable {

    enum CodingKeys: String, CodingKey {
        case api = "self"
        case site = "public"
        case external
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

        guard let entity = NSEntityDescription.entity(forEntityName: "HeadlineURLs", in: context) else {
            throw CoreDataInitializationErrors.noEntity
        }

        self.init(entity: entity, insertInto: context)

        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.api = try container.decodeIfPresent(URL.self, forKey: .api)
        self.site = try container.decodeIfPresent(URL.self, forKey: .site)
        self.external = try container.decodeIfPresent(URL.self, forKey: .external)
    }

}
