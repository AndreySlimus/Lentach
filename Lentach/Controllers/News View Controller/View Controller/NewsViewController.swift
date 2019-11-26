//
//  NewsViewController.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//

import UIKit
import AVKit
import CoreData

class NewsViewController: UIViewController {

    // MARK: - Public Properties
    // MARK: -- Model Properties
    var headline: Headline?

    // MARK: - Private Properties
    // MARK: -- Model Properties
    private var news: News?

    var _fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>?

    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>? {

        if _fetchedResultsController != nil {
            return _fetchedResultsController
        }

        let fetchRequest: NSFetchRequest<Headline> = Headline.fetchRequest()
        fetchRequest.fetchBatchSize = 15

        let sortDescriptor = NSSortDescriptor(key: "info.modified", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]

        let predicate = NSPredicate(format: "category == %@ && associatedNews == %@",
                                    Headline.Category.associated.rawValue, self.news ?? "")

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
            print("Method: NewsViewController.fetchedResultsController \nError: \(nserror.localizedDescription)")
        }

        return _fetchedResultsController
    }

    // MARK: -- UI Properties
    private let scrollView = NewsContentScrollView()
    private var activityIndicator = ActivityIndicator.standardStyle()
    private var imageView = NewsImageInfoView()
    private var previewView = NewsPreviewContentView()
    private var errorLabel: LentachLabel?
    private var textView: NewsTextContentView?
    private var previewVideoView: PreviewVideoView?
    private var associatedHeadlinesTableView: AssociatedHeadlinesTableView?
    private var isFavoriteButton: UIBarButtonItem?

    private var isTransparentNavigationBar: (isTransparent: Bool, animate: Bool) = (false, false) {
        didSet {
            switch self.isTransparentNavigationBar {
            case (true, true):
                self.navigationController?.navigationBar.setTransparency(true, animated: true)
            case (true, false):
                self.navigationController?.navigationBar.setTransparency(true, animated: false)
            case (false, true):
                self.navigationController?.navigationBar.setTransparency(false, animated: true)
            case (false, false):
                self.navigationController?.navigationBar.setTransparency(false, animated: false)
            }
        }
    }

    private lazy var offsetForChangingStateNavigationBar: CGFloat = {

        if let maxYOfNavigationBar = self.navigationController?.navigationBar.frame.maxY {
            return 250 - maxYOfNavigationBar
        } else {
            return 0
        }
    }()

    private var centerEmptyArea: CGPoint {

        let centerY = (self.view.frame.height - self.scrollView.heightOfContentView) / 2,
            pointY = self.scrollView.heightOfContentView + centerY,
            pointX = self.view.center.x

        return CGPoint.init(x: pointX, y: pointY)
    }

    // MARK: - Lifecycle
    // MARK: -- ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupScrollView()
        setupImageView()
        setupPreviewView()

        settings()
        settingsNavigationBar()

        configureImageInfoView()
        configurePreviewView()

        setupActivityIndicator()

        requestNews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if self.scrollView.contentOffset.y > self.offsetForChangingStateNavigationBar {
            self.isTransparentNavigationBar = (isTransparent: false, animate: true)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        self.navigationItem.deleteTitleBackButton()
    }

    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)

        self.navigationController?.navigationBar.prefersLargeTitles = true

        self.navigationController?.navigationBar.setTransparency(false, animated: false)
    }

    // MARK: - Private Methods
    // MARK: -- Setup UI
    private func setupScrollView() {

        self.scrollView.frame = CGRect.zero
        self.scrollView.delegate = self
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false

        if #available(iOS 11.0, *) {
            self.scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }

        self.view.addSubview(self.scrollView)

        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])

        self.scrollView.setupViews()
    }

    private func setupImageView() {

        self.imageView.frame = CGRect.zero
        self.scrollView.add(view: self.imageView, toContainerWithType: .image)
    }

    private func setupPreviewView() {

        self.previewView.frame = CGRect.zero
        self.scrollView.add(view: self.previewView, toContainerWithType: .preview)
    }

    private func setupTextView() {

        self.textView = NewsTextContentView.init(frame: CGRect.zero)
        if let textView = self.textView {
           self.scrollView.add(view: textView, toContainerWithType: .text)
        }
    }

    private func setupPreviewVideoView() {

        self.previewVideoView = PreviewVideoView.init(frame: CGRect.zero)
        self.previewVideoView?.delegate = self
        if let previewVideoView = self.previewVideoView {
            self.scrollView.add(view: previewVideoView, toContainerWithType: .video)
        }
    }

    private func setupAssociatedHeadlinesTableView() {

        guard
            let news = self.news,
            let headlineTypes = news.associatedHeadlinesTypes
            else {
                return
        }

        let height = AssociatedHeadlinesView.standardHeight +
            HeadlineCell.standardHeight * CGFloat(headlineTypes.news) +
            ExternalHeadlineCell.standardHeight * CGFloat(headlineTypes.extlink)

        self.associatedHeadlinesTableView = AssociatedHeadlinesTableView.init(frame: CGRect.init(x: 0,
                                                                                                 y: 0,
                                                                                                 width: self.view.bounds.width,
                                                                                                 height: height),
                                                                              style: .plain)

        self.associatedHeadlinesTableView?.delegate = self
        self.associatedHeadlinesTableView?.dataSource = self

        if let associatedHeadlinesTableView = self.associatedHeadlinesTableView {
            self.scrollView.add(view: associatedHeadlinesTableView, toContainerWithType: .table)
        }
    }

    private func setupActivityIndicator() {

        self.activityIndicator.color = .lentachGray
        self.activityIndicator.startAnimating()
        self.activityIndicator.center = self.centerEmptyArea

        self.view.addSubview(self.activityIndicator)
    }

    private func setupErrorLabel() {

        self.errorLabel = LentachLabel.init(frame: CGRect.init(x: 0, y: 0, width: 300, height: 100),
                                            fontSize: 18)

        self.errorLabel?.center = self.centerEmptyArea
        self.errorLabel?.text = "Не удается загрузить данные"
        self.errorLabel?.contentMode = .center
        self.errorLabel?.textAlignment = .center

        if let errorLabel = self.errorLabel {
            self.view.addSubview(errorLabel)
        }
    }

    private func setupFavoriteBarButton(isFavorite: Bool) {

        self.isFavoriteButton = UIBarButtonItem.init(image: nil,
                                                     style: .plain,
                                                     target: self,
                                                     action: #selector(changeFavoriteStatusNews))

        switch isFavorite {
        case true:
            self.isFavoriteButton?.image = UIImage.init(named: "delete-from-favorite")
        case false:
            self.isFavoriteButton?.image = UIImage.init(named: "add-to-favorite")
        }

        self.navigationItem.rightBarButtonItem = self.isFavoriteButton
    }

    // MARK: -- Settings UI
    private func settings() {

        self.extendedLayoutIncludesOpaqueBars = true
    }

    private func settingsNavigationBar() {

        self.navigationController?.navigationBar.prefersLargeTitles = false

        self.isTransparentNavigationBar = (isTransparent: true, animate: false)
    }

    // MARK: -- Configure UI
    private func configureImageInfoView() {

        guard let headline = self.headline else { return }

        NewsViewControllerPresenter.createNewsImageInfoViewModel(headline: headline) { viewModel in

            DispatchQueue.main.async {
                self.imageView.configure(viewModel)
                self.scrollView.updateHeightContentView()
            }
        }
    }

    private func configurePreviewView() {

        guard let headline = self.headline else { return }

        let viewModel = NewsViewControllerPresenter.createNewsPreviewContentViewModel(headline: headline)

        self.previewView.configure(viewModel)

        self.scrollView.updateHeightContentView()
    }

    private func configureTextView() {

        guard let news = self.news else { return }

        let viewModel = NewsViewControllerPresenter.createNewsTextContentViewModel(news: news)

        self.textView?.configure(viewModel)

        self.scrollView.updateHeightContentView()
    }

    private func configurePreviewVideoView() {

        guard let news = self.news else { return }

        NewsViewControllerPresenter.createPreviewVideoViewModel(news: news) { viewModel in

            DispatchQueue.main.async {
                self.previewVideoView?.configure(viewModel)
                self.scrollView.updateHeightContentView()
            }
        }
    }

    func configureCell(_ cell: UITableViewCell, withHeadline headline: Headline) {

        switch headline.type {
        case Headline.Types.news.rawValue:

            if let headlineCell = cell as? HeadlineCell {
                HeadlineCellPresenter.createViewModel(headline: headline) { viewModel in
                    if let viewModel = viewModel {
                        DispatchQueue.main.async {
                            headlineCell.configure(viewModel)
                        }
                    }
                }
            }

        case Headline.Types.external.rawValue:

            if let externalHeadlineCell = cell as? ExternalHeadlineCell {
                let viewModel = ExternalHeadlineCellPresenter.createViewModel(headline: headline)
                DispatchQueue.main.async {
                    externalHeadlineCell.configure(viewModel)
                }
            }

        default: break
        }
    }

    // MARK: -- Other
    private func requestNews() {

        guard let headline = self.headline else { return }

        switch headline.isHaveSavedNews {
        case false:

            guard let url = headline.urls?.api else { return }

            Network.requestNews(with: url) { [weak self] response in

                switch response {
                case .success(let data):
                    CoreDataStorageManager.saveNews(from: data,
                                                    withHeadline: headline,
                                                    completionHandler: { [weak self] isSuccsessSave in

                                                        if isSuccsessSave {
                                                            self?.news = headline.savedNews
                                                            self?.parseNews()
                                                        } else {
                                                            self?.activityIndicator.stopAnimating()
                                                            self?.setupErrorLabel()
                                                        }
                    })
                case .failure:
                    self?.activityIndicator.stopAnimating()
                    self?.setupErrorLabel()
                }
            }
        case true:
            self.news = headline.savedNews
            parseNews()
        }
    }

    private func parseNews() {

        guard let news = self.news else { return }

        self.scrollView.changeBackgroundColor()

        if news.text != nil {
            setupTextView()
            configureTextView()
        }

        if news.video != nil {
            setupPreviewVideoView()
            configurePreviewVideoView()
        }

        if news.associatedHeadlines != nil {
            setupAssociatedHeadlinesTableView()
        }

        setupFavoriteBarButton(isFavorite: news.favorites)

        self.activityIndicator.stopAnimating()
    }

    @objc private func changeFavoriteStatusNews() {

        guard let news = self.news else { return }

        CoreDataStorageManager.changeFavoriteValueNews(news) {

            switch news.favorites {
            case true:
                self.isFavoriteButton?.image = UIImage.init(named: "delete-from-favorite")
            case false:
                self.isFavoriteButton?.image = UIImage.init(named: "add-to-favorite")
            }
        }
    }

    // MARK: - Navigation
    private func presentPlayerController() {

        guard let url = self.news?.video?.watchURL else { return }

        let playerController = AVPlayerViewController()
        playerController.player = AVPlayer.init(url: url)

        self.present(playerController, animated: true) {
            if let player = playerController.player {
                player.play()
            }
        }
    }

    private func presentWebViewController(withURL url: URL) {

        let webViewController = WebViewController.init(withURL: url)
        let navigationController = UINavigationController.init(rootViewController: webViewController)

        self.navigationController?.present(navigationController, animated: true, completion: nil)
    }

    private func pushNewsViewController(withHeadline headline: Headline) {

        let newsViewController = NewsViewController()
        newsViewController.headline = headline

        self.navigationController?.pushViewController(newsViewController, animated: true)
    }

    private func associatedHeadlinesNavigationCoordinator(selectCellAtIndexPath indexPath: IndexPath) {

        guard let headline = self.fetchedResultsController?.object(at: indexPath) as? Headline else {
            return
        }

        switch headline.type {
        case Headline.Types.news.rawValue:
            pushNewsViewController(withHeadline: headline)
        case Headline.Types.external.rawValue:
            guard let url = headline.urls?.external else { break }
            presentWebViewController(withURL: url)
        default: break
        }
    }

}

// MARK: - Delegate: UIScrollViewDelegate
extension NewsViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        switch scrollView.contentOffset.y {
        // changing the transparent of navigation bar
        // hide
        case 0..<self.offsetForChangingStateNavigationBar where !self.isTransparentNavigationBar.isTransparent:
            self.isTransparentNavigationBar = (isTransparent: true, animate: true)
        // show
        case self.offsetForChangingStateNavigationBar... where self.isTransparentNavigationBar.isTransparent:
            self.isTransparentNavigationBar = (isTransparent: false, animate: true)
        default: break
        }

        scrollView.changeColorVerticalScrollIndicator(to: .lentachGray)
    }

}

// MARK: - Delegate: PreviewVideoViewDelegate
extension NewsViewController: PreviewVideoViewDelegate {

    func didTapPlayButton(_ previewVideoView: PreviewVideoView) {
        presentPlayerController()
    }

}

// MARK: - Delegate: UITableViewDelegate
extension NewsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        associatedHeadlinesNavigationCoordinator(selectCellAtIndexPath: indexPath)

        tableView.deselectRow(at: indexPath, animated: true)
    }

}

// MARK: - Delegate: UITableViewDataSource
extension NewsViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.fetchedResultsController?.sections?.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fetchedResultsController?.sections?[section].numberOfObjects ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let headline = self.fetchedResultsController?.object(at: indexPath) as? Headline else {
            return UITableViewCell()
        }

        switch headline.type {
        case Headline.Types.news.rawValue:
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: HeadlineCell.reuseIdentifier,
                                                           for: indexPath) as? HeadlineCell
                else {
                    return UITableViewCell()
            }
            configureCell(cell, withHeadline: headline)
            return cell
        case Headline.Types.external.rawValue:
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: ExternalHeadlineCell.reuseIdentifier,
                                                         for: indexPath) as? ExternalHeadlineCell
                else {
                    return UITableViewCell()
            }
            configureCell(cell, withHeadline: headline)
            return cell
        default: break
        }

        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        guard let headline = self.fetchedResultsController?.object(at: indexPath) as? Headline else {
            return 0
        }

        switch headline.type {
        case Headline.Types.news.rawValue:
            return HeadlineCell.standardHeight
        case Headline.Types.external.rawValue:
            return ExternalHeadlineCell.standardHeight
        default: return 0
        }
    }

}

// MARK: - Delegate: NSFetchedResultsController
extension NewsViewController: NSFetchedResultsControllerDelegate {

    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {

        self.associatedHeadlinesTableView?.beginUpdates()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange sectionInfo: NSFetchedResultsSectionInfo,
                    atSectionIndex sectionIndex: Int,
                    for type: NSFetchedResultsChangeType) {

        switch type {
        case .insert:
            self.associatedHeadlinesTableView?.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete:
            self.associatedHeadlinesTableView?.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
        default:
            return
        }
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {

        guard
            let indexPath = indexPath,
            let newIndexPath = newIndexPath
            else {
                return
        }

        switch type {
        case .insert:
            self.associatedHeadlinesTableView?.insertRows(at: [newIndexPath], with: .fade)
        case .delete:
            self.associatedHeadlinesTableView?.deleteRows(at: [indexPath], with: .fade)
        case .update:

            guard
                let headline = anObject as? Headline,
                let cell = self.associatedHeadlinesTableView?.cellForRow(at: indexPath)
                else {
                    return
            }

            configureCell(cell, withHeadline: headline)
        case .move:

            guard
                let headline = anObject as? Headline,
                let cell = self.associatedHeadlinesTableView?.cellForRow(at: indexPath)
                else {
                    return
            }

            configureCell(cell, withHeadline: headline)

            self.associatedHeadlinesTableView?.moveRow(at: indexPath, to: newIndexPath)
        }
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {

        self.associatedHeadlinesTableView?.endUpdates()
    }

}
