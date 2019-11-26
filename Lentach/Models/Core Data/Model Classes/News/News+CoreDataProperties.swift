//
//  News+CoreDataProperties.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//
//

import Foundation
import CoreData

extension News {

    // MARK: - Class Methods
    @nonobjc public class func fetchRequest() -> NSFetchRequest<News> {
        return NSFetchRequest<News>(entityName: "News")
    }

    // MARK: - Public Properties
    // MARK: -- Model Properties
    @NSManaged public var favorites: Bool
    @NSManaged public var text: String?
    @NSManaged public var associatedHeadlines: NSSet?
    @NSManaged public var headline: Headline?
    @NSManaged public var video: NewsVideo?

}

extension News {

    // MARK: - Public Methods
    // MARK: - Generated accessors for associatedHeadlines
    @objc(addAssociatedHeadlinesObject:)
    @NSManaged public func addToAssociatedHeadlines(_ value: Headline)

    @objc(removeAssociatedHeadlinesObject:)
    @NSManaged public func removeFromAssociatedHeadlines(_ value: Headline)

    @objc(addAssociatedHeadlines:)
    @NSManaged public func addToAssociatedHeadlines(_ values: NSSet)

    @objc(removeAssociatedHeadlines:)
    @NSManaged public func removeFromAssociatedHeadlines(_ values: NSSet)

}

extension News {

    // MARK: - Public Properties
    // MARK: -- Model Properties
    var associatedHeadlinesTypes: (news: Int, extlink: Int)? {

        guard let associatedHeadlines = self.associatedHeadlines as? Set<Headline> else {
            return (news: 0, extlink: 0)
        }

        var newsCount = 0, extlinkCount = 0

        associatedHeadlines.forEach { headline in

            switch headline.type {
            case Headline.Types.news.rawValue: newsCount += 1
            case Headline.Types.external.rawValue: extlinkCount += 1
            default: break
            }
        }

        return (news: newsCount, extlink: extlinkCount)
    }

}
