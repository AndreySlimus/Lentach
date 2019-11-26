//
//  CoreDataManager.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {

    // MARK: - Static Properties
    // MARK: -- Public
    static let shared = CoreDataManager()

    // MARK: - Public Properties
    // MARK: -- Model Properties
    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "Lentach")

        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })

        return container
    }()

    lazy var context: NSManagedObjectContext = {

        let context = self.persistentContainer.viewContext

        return context
    }()

    var backgroundContext: NSManagedObjectContext {
        return persistentContainer.newBackgroundContext()
    }

    var privateQueueContext: NSManagedObjectContext {

        let context = NSManagedObjectContext.init(concurrencyType: .privateQueueConcurrencyType)
        context.parent = self.context

        return context
    }

    // MARK: - Lifecycle
    // MARK: -- Initializations
    private init() { }

    // MARK: - Public Methods
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                print("Method: CoreDataManager.saveContext \nError: \(nserror.localizedDescription)")
            }
        }
    }

}
