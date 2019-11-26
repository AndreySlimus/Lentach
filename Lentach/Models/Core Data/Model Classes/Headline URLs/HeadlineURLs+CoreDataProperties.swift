//
//  HeadlineURLs+CoreDataProperties.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//
//

import Foundation
import CoreData

extension HeadlineURLs {

    // MARK: - Class Methods
    @nonobjc public class func fetchRequest() -> NSFetchRequest<HeadlineURLs> {
        return NSFetchRequest<HeadlineURLs>(entityName: "HeadlineURLs")
    }

    // MARK: - Public Properties
    // MARK: -- Model Properties
    @NSManaged public var api: URL?
    @NSManaged public var external: URL?
    @NSManaged public var site: URL?
    @NSManaged public var headline: Headline?

}
