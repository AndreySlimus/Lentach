//
//  FavoritesHeadlinesViewController.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//

import UIKit
import CoreData

class FavoritesHeadlinesViewController: BasicHeadlinesViewController {

    // MARK: - Private Properties
    // MARK: -- Model Properties
    override internal var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>? {

        if _fetchedResultsController != nil {
            return _fetchedResultsController
        }

        let fetchRequest: NSFetchRequest<Headline> = Headline.fetchRequest()

        fetchRequest.fetchBatchSize = 10

        let sortDescriptor = NSSortDescriptor(key: "info.modified", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]

        let predicate = NSPredicate(format: "news.favorites == %@ && type == %@",
                                            NSNumber.init(value: true), Headline.Types.news.rawValue)
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
            print("Method: FavoritesHeadlinesViewController.fetchedResultsController \nError: \(nserror.localizedDescription)")
        }

        return _fetchedResultsController
    }

    // MARK: -- UI Properties
    private lazy var noFavoritesHeadlinesView: NoFavoritesHeadlinesView? = {
        return NoFavoritesHeadlinesView.instanceFromNib()
    }()

    // MARK: - Lifecycle
    // MARK: -- Initializers
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        addManagedObjectsContextDidChangeObserver()
    }

    // MARK: -- ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        deleteActivivtyIndicator()
        deleteRefreshControl()

        settingsNavigationItemTitle()

        checkingSavedHeadlines()
    }

    // MARK: -- Deinitialization
    deinit {

        removeManagedObjectsContextDidChangeObserver()
    }

    // MARK: - Private Methods
    // MARK: -- Setup UI
    fileprivate func setupNoFavoritesHeadlinesView() {

        self.tableView?.backgroundView = self.noFavoritesHeadlinesView
    }

    // MARK: -- Settings UI
    fileprivate func settingsNavigationItemTitle() {

        self.navigationItem.title = "Избранные новости"
    }

    fileprivate func deleteActivivtyIndicator() {

        self.activityIndicator.removeFromSuperview()
    }

    fileprivate func deleteRefreshControl() {

        self.tableView?.refreshControl = nil
    }

    fileprivate func deleteNoFavoritesHeadlinesView() {

        self.tableView?.backgroundView = nil
    }

    // MARK: -- Other
    fileprivate func addManagedObjectsContextDidChangeObserver() {

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(managedObjectsDidChangeHandler(notification:)),
                                               name: .NSManagedObjectContextDidSave,
                                               object: CoreDataManager.shared.context
        )
    }

    fileprivate func removeManagedObjectsContextDidChangeObserver() {

        NotificationCenter.default.removeObserver(self,
                                                  name: .NSManagedObjectContextDidSave,
                                                  object: CoreDataManager.shared.context
        )
    }

    @objc fileprivate func managedObjectsDidChangeHandler(notification: NSNotification) {

        if let tableView = self.tableView {

            try? self.fetchedResultsController?.performFetch()

            checkingSavedHeadlines()

            DispatchQueue.main.async {
                tableView.reloadData()
            }
        }
    }

    fileprivate func checkingSavedHeadlines() {

        if self.fetchedResultsController?.fetchedObjects?.count == 0 {
            DispatchQueue.main.async {
                self.setupNoFavoritesHeadlinesView()
                self.tableView?.isScrollEnabled = false
            }
        } else {
            DispatchQueue.main.async {
                self.deleteNoFavoritesHeadlinesView()
                self.tableView?.isScrollEnabled = true
            }
        }
    }

}
