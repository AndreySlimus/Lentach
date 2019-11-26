//
//  HeadlineImageMetadata+CoreDataProperties.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//
//

import Foundation
import CoreData

extension HeadlineImageMetadata {

    // MARK: - Class Methods
    @nonobjc public class func fetchRequest() -> NSFetchRequest<HeadlineImageMetadata> {
        return NSFetchRequest<HeadlineImageMetadata>(entityName: "HeadlineImageMetadata")
    }

    // MARK: - Public Properties
    // MARK: -- Model Properties
    @NSManaged public var author: String?
    @NSManaged public var caption: String?
    @NSManaged public var url: URL?
    @NSManaged public var headline: Headline?

}
