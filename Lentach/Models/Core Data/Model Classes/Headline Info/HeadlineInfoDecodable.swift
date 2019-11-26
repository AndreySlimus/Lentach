//
//  HeadlineInfoDecodable.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation
import CoreData

extension HeadlineInfo: Decodable {

    enum CodingKeys: String, CodingKey {
        case title, rightcol, modified
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

        guard let entity = NSEntityDescription.entity(forEntityName: "HeadlineInfo", in: context) else {
            throw CoreDataInitializationErrors.noEntity
        }

        self.init(entity: entity, insertInto: context)

        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.rightcol = try container.decodeIfPresent(String.self, forKey: .rightcol)
        self.modified = try container.decodeIfPresent(Double.self, forKey: .modified) ?? 0.0
    }

}
