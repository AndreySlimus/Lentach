//
//  PopularHeadlinesViewController.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//
import UIKit
import CoreData

class PopularHeadlinesViewController: BasicHeadlinesViewController {

    // MARK: - Private Properties
    // MARK: -- Model Properties
    override var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>? {

        if _fetchedResultsController != nil {
            return _fetchedResultsController
        }

        let fetchRequest: NSFetchRequest<Headline> = Headline.fetchRequest()

        fetchRequest.fetchBatchSize = 15

        let sortDescriptor = NSSortDescriptor(key: "info.modified", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]

        let predicate = NSPredicate(format: "category == %@ && type == %@",
                                            Headline.Category.popular.rawValue, Headline.Types.news.rawValue)
        fetchRequest.predicate = predicate

        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                   managedObjectContext: CoreDataManager.shared.context,
                                                                   sectionNameKeyPath: nil,
                                                                   cacheName: nil)

        aFetchedResultsController.delegate = self

        _fetchedResultsController = aFetchedResultsController as? NSFetchedResultsController<NSFetchRequestResult>

        do {
            try _fetchedResultsController?.performFetch()
        } catch {
            let nserror = error as NSError
            print("Method: PopularHeadlinesViewController.fetchedResultsController \nError: \(nserror.localizedDescription)")
        }

        return _fetchedResultsController
    }

    // MARK: - Lifecycle
    // MARK: -- ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        settingsNavigationItemTitle()

        requestPopularHeadlines()
    }

    // MARK: - Private Methods
    // MARK: -- Settings UI
    fileprivate func settingsNavigationItemTitle() {

        self.navigationItem.title = "Популярные новости"
    }

    // MARK: -- Actions UI
    override func refreshHeadlines() {

        self.requestPopularHeadlines()
    }

    // MARK: -- Other
    fileprivate func requestPopularHeadlines() {

        switch NetworkStatus.isConnected {
        case true:
            Network.requestHeadlines(category: .popular) { response in
                if let data = try? response.resolve() {
                    CoreDataStorageManager.saveHeadlines(from: data, category: .popular)
                }
            }
        case false:
            setupNetworkConnectionErrorView()
        }
    }

}
