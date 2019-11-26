//
//  Headline+CoreDataProperties.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//
//

import Foundation
import CoreData

extension Headline {

    // MARK: - Class Methods
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Headline> {
        return NSFetchRequest<Headline>(entityName: "Headline")
    }

    // MARK: - Public Properties
    // MARK: -- Model Properties
    @NSManaged public var category: String?
    @NSManaged public var type: String?
    @NSManaged public var imageMetadata: HeadlineImageMetadata?
    @NSManaged public var info: HeadlineInfo?
    @NSManaged public var news: News?
    @NSManaged public var urls: HeadlineURLs?
    @NSManaged public var associatedNews: News?

}

extension Headline {

    enum Category: String {
        case latest
        case popular
        case associated
    }

    enum Types: String, Decodable {
        case article
        case external = "external_link"
        case news
        case another

        init(from decoder: Decoder) throws {

            self = try Types(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .another
        }
    }

    // MARK: - Public Properties
    // MARK: -- Model Properties
    var isHaveSavedNews: Bool {

        switch self.value(forKey: "news") {
        case nil: return false
        default: return true
        }
    }

    var savedNews: News? {
        return self.value(forKey: "news") as? News
    }

}
