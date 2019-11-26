//
//  NewsVideo+CoreDataProperties.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//
//

import Foundation
import CoreData

extension NewsVideo {

    // MARK: - Class Methods
    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewsVideo> {
        return NSFetchRequest<NewsVideo>(entityName: "NewsVideo")
    }

    // MARK: - Public Properties
    // MARK: -- Model Properties
    @NSManaged public var title: String?
    @NSManaged public var watchURL: URL?
    @NSManaged public var imageURL: URL?
    @NSManaged public var news: News?

}
