//
//  WebViewController.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    // MARK: - Private Properties
    // MARK: -- Model Properties
    private var url: URL?

    // MARK: -- UI Properties
    private var webView = WKWebView()
    private var activityIndicator = ActivityIndicator.standardStyle()

    // MARK: - Lifecycle
    // MARK: -- Initializations
    required init(withURL url: URL) {
        super.init(nibName: nil, bundle: nil)

        self.url = url
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: -- ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupWebView()
        setupActivityIndicator()
        setupCloseButton()

        settingsNavigationBar()

        configureWebView()
    }

    // MARK: - Private Methods
    // MARK: -- Setup UI
    fileprivate func setupWebView() {

        self.webView.frame = self.view.frame
        self.webView.translatesAutoresizingMaskIntoConstraints = false

        self.webView.navigationDelegate = self

        self.view.addSubview(self.webView)

        NSLayoutConstraint.activate([
            self.webView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.webView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.webView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.webView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }

    fileprivate func setupActivityIndicator() {

        self.activityIndicator.center = self.view.center
        self.activityIndicator.color = UIColor.lentachGray
        self.activityIndicator.startAnimating()

        self.view.addSubview(self.activityIndicator)
    }

    fileprivate func setupCloseButton() {

        let closeButton = UIBarButtonItem.init(image: UIImage.init(named: "close-button"),
                                               style: .done,
                                               target: self,
                                               action: #selector(dismissViewController))

        self.navigationItem.leftBarButtonItem = closeButton
    }

    // MARK: -- Settings UI
    fileprivate func settingsNavigationBar() {

        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = .lentachGray
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.init(name: "Akrobat-SemiBold", size: 17) as Any
        ]

        self.navigationItem.title = self.url?.absoluteString.siteAddress
    }

    // MARK: -- Configure UI
    fileprivate func configureWebView() {

        if let url = self.url {
            let request = URLRequest.init(url: url)
            self.webView.load(request)
        }
    }

    // MARK: - Navigation
    @objc func dismissViewController() {

        self.dismiss(animated: true, completion: nil)
    }

}

// MARK: - Delegate: WKNavigationDelegate
extension WebViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation?) {

        self.activityIndicator.stopAnimating()
    }

}
