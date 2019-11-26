//
//  BasicHeadlinesViewController.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//

import UIKit
import CoreData

class BasicHeadlinesViewController: UIViewController {

    // MARK: - Public Properties
    var _fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>?

    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>? {
        return nil
    }

    // MARK: - Private Properties
    // MARK: -- Outlets
    @IBOutlet var tableView: UITableView?

    // MARK: -- UI Properties
    let activityIndicator = ActivityIndicator.standardStyle()
    let refreshControl = RefreshControl.standardStyle()

    // MARK: - Lifecycle
    // MARK: -- ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        settingsNavigationBar()
        settingsTableView()
        settingsRefreshControl()
        settingsActivityIndicator()

        checkingNeedingSetupNetworkConnectionErrorView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.navigationBar.setTransparency(false, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        self.navigationItem.deleteTitleBackButton()
    }

    // MARK: - Private Methods
    // MARK: -- Setup UI
    func setupNetworkConnectionErrorView() {

        let networkConnectionErrorView = NetworkConnectionErrorView.instanceFromNib()

        if let dateLatestUpdateHeadlines = UserDefaultsManager.dateLatestUpdateHeadlines {
            networkConnectionErrorView?.setDateLatestUpdate(DatePreparer.dateString(dateLatestUpdateHeadlines))
        }

        self.tableView?.tableHeaderView = networkConnectionErrorView
    }

    // MARK: -- Settings UI
    fileprivate func settingsNavigationBar() {

        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
    }

    fileprivate func settingsTableView() {

        self.tableView?.delegate = self
        self.tableView?.dataSource = self

        self.tableView?.indicatorStyle = .white
        self.tableView?.backgroundColor = .lentachGray
        self.tableView?.tableFooterView = UIView()

        self.tableView?.register(UINib.init(nibName: "HeadlineCell",
                                           bundle: nil),
                                forCellReuseIdentifier: HeadlineCell.reuseIdentifier)
    }

    fileprivate func settingsActivityIndicator() {

        self.activityIndicator.center = self.view.center
        self.activityIndicator.startAnimating()

        self.view.addSubview(self.activityIndicator)
    }

    fileprivate func settingsRefreshControl() {

        if let tableViewRefreshControl = self.tableView?.refreshControl {
            self.refreshControl.frame = tableViewRefreshControl.frame
        }

        self.refreshControl.addTarget(self, action: #selector(refreshHeadlines),
                                      for: .valueChanged)

        if #available(iOS 10.0, *) {
            tableView?.refreshControl = self.refreshControl
        } else {
            tableView?.addSubview(self.refreshControl)
        }
    }

    // MARK: -- Configure UI
    func configureHeadlineCell(_ cell: HeadlineCell,
                               withHeadline headline: Headline,
                               atIndexPath indexPath: IndexPath) {

        HeadlineCellPresenter.createViewModel(headline: headline) { viewModel in

            DispatchQueue.main.async {

                guard
                    let viewModel = viewModel,
                    let tableView = self.tableView,
                    let updatableСell = tableView.cellForRow(at: indexPath) as? HeadlineCell
                    else {
                        return
                }

                updatableСell.configure(viewModel)
            }
        }
    }

    // MARK: -- Actions UI
    @objc func refreshHeadlines() {

    }

    // MARK: -- Other
    fileprivate func checkingNeedingSetupNetworkConnectionErrorView() {

        if !NetworkStatus.isConnected {
            setupNetworkConnectionErrorView()
        }
    }

    func deleteNetworkConnectionErrorView() {

        self.tableView?.tableHeaderView = nil
    }

    fileprivate func beginUpdatesContent() {

        self.activityIndicator.startAnimating()
    }

    fileprivate func endUpdatesContent() {

        self.activityIndicator.stopAnimating()

        guard
            let refreshControl = self.tableView?.refreshControl,
            refreshControl.isRefreshing
            else {
                return
        }

        refreshControl.endRefreshing()
    }

    // MARK: - Navigation
    private func pushNewsViewController(withHeadline headline: Headline) {

        let newsViewController = NewsViewController()
        newsViewController.headline = headline

        newsViewController.hidesBottomBarWhenPushed = true

        self.navigationController?.pushViewController(newsViewController, animated: true)
    }

}

// MARK: - Delegate: UITableViewDataSource
extension BasicHeadlinesViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.fetchedResultsController?.sections?.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fetchedResultsController?.sections?[section].numberOfObjects ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard
            let headline = self.fetchedResultsController?.object(at: indexPath) as? Headline,
            let cell = tableView.dequeueReusableCell(withIdentifier: HeadlineCell.reuseIdentifier,
                                                     for: indexPath) as? HeadlineCell
            else {
                return UITableViewCell()
        }

        configureHeadlineCell(cell,
                              withHeadline: headline,
                              atIndexPath: indexPath)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }

}

// MARK: - Delegate: UITableViewDelegate
extension BasicHeadlinesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if let headline = self.fetchedResultsController?.object(at: indexPath) as? Headline {
            pushNewsViewController(withHeadline: headline)
        }
    }

}

// MARK: - Delegate: NSFetchedResultsController
extension BasicHeadlinesViewController: NSFetchedResultsControllerDelegate {

    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {

        tableView?.beginUpdates()
        beginUpdatesContent()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange sectionInfo: NSFetchedResultsSectionInfo,
                    atSectionIndex sectionIndex: Int,
                    for type: NSFetchedResultsChangeType) {

        switch type {
        case .insert:
            tableView?.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete:
            tableView?.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
        default:
            return
        }
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {

        switch type {
        case .insert:
            guard
                let newIndexPath = newIndexPath,
                let tableView = self.tableView
                else {
                    return
            }
            tableView.insertRows(at: [newIndexPath], with: .fade)
        case .delete:
            guard
                let indexPath = indexPath,
                let tableView = self.tableView
                else {
                    return
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        case .update:
            guard
                let indexPath = indexPath,
                let tableView = self.tableView,
                let cell = tableView.cellForRow(at: indexPath) as? HeadlineCell,
                let headline = anObject as? Headline
                else {
                    return
            }
            configureHeadlineCell(cell,
                                  withHeadline: headline,
                                  atIndexPath: indexPath)
        case .move:
            guard
                let indexPath = indexPath,
                let tableView = self.tableView,
                let cell = tableView.cellForRow(at: indexPath) as? HeadlineCell,
                let headline = anObject as? Headline,
                let newIndexPath = newIndexPath
                else {
                    return
            }
            configureHeadlineCell(cell,
                                  withHeadline: headline,
                                  atIndexPath: indexPath)
            tableView.moveRow(at: indexPath, to: newIndexPath)
        }
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {

        tableView?.endUpdates()
        endUpdatesContent()
    }

}
