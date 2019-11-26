//
//  Network.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//

import UIKit

class Network {

    // MARK: - Private Static Properties
    private static let addressAPI = "https://api.lenta.ru/lists/"

    // MARK: - Static Functions
    static func requestNews(with url: URL, completionHandler: @escaping DataLoadedCompletion) {

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                DispatchQueue.main.async {
                    completionHandler(.success(data))
                }
            } else if let error = error as NSError? {
                DispatchQueue.main.async {
                    completionHandler(.failure(error))
                }
            }
        }.resume()
    }

    static func requestHeadlines(category: Headline.Category,
                                 completionHandler: @escaping DataLoadedCompletion) {

        let categoryAddressAPI = addressAPI + category.rawValue

        guard let url = URL.init(string: categoryAddressAPI) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                DispatchQueue.main.async {
                    completionHandler(.success(data))
                }
            } else if let error = error as NSError? {
                DispatchQueue.main.async {
                    completionHandler(.failure(error))
                }
            }
        }.resume()
    }

    static func loadImage(url: URL, completionHandler: @escaping ImageLoadedCompletion) {

        URLSession.shared.dataTask(with: url) { data, _, error in

            if let data = data, let image = UIImage.init(data: data) {
                completionHandler(.success(image))
            } else if let error = error as NSError? {
                completionHandler(.failure(error))
            }

        }.resume()
    }

}
