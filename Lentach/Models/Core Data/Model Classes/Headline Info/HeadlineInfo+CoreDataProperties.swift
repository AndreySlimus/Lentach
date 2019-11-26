//
//  HeadlineInfo+CoreDataProperties.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//
//

import Foundation
import CoreData

extension HeadlineInfo {

    // MARK: - Class Methods
    @nonobjc public class func fetchRequest() -> NSFetchRequest<HeadlineInfo> {
        return NSFetchRequest<HeadlineInfo>(entityName: "HeadlineInfo")
    }

    // MARK: - Public Properties
    // MARK: -- Model Properties
    @NSManaged public var rightcol: String?
    @NSManaged public var modified: Double
    @NSManaged public var title: String?
    @NSManaged public var headline: Headline?

}
