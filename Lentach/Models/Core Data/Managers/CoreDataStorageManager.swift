//
//  CoreDataStorageManager.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStorageManager {

    // MARK: - Static Methods
    // MARK: -- Public
    static func saveHeadlines(from data: Data, category: Headline.Category) {

        deleteHeadlines(category: category) {

            let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
            context.parent = CoreDataManager.shared.context

            context.perform {
                do {
                    guard
                        let codingUserInfoContext = CodingUserInfoKey.context,
                        let codingUserInfoType = CodingUserInfoKey.type
                        else {
                            return
                    }

                    let decoder = JSONDecoder()
                    decoder.userInfo[codingUserInfoContext] = context
                    decoder.userInfo[codingUserInfoType] = category

                    _ = try? decoder.decode(HeadlinesInitializer.self, from: data)

                    try context.save()
                } catch let error as NSError {
                    print("Method: CoreDataStorageManager.saveHeadlines \nError: \(error.localizedDescription)")
                }

                CoreDataManager.shared.saveContext()

                UserDefaultsManager.rewriteDateLatestUpdateHeadlines()

                CoreDataStorageManager.imagesURLsForHeadlines(category: category, completionHandler: { urls in
                    guard let urls = urls else { return }
                    ImagesFileManager.updateDirectory(newURLs: urls)
                })
            }
        }
    }

    static func saveNews(from data: Data,
                         withHeadline headline: Headline,
                         completionHandler: @escaping (Bool) -> Void) {

        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.parent = CoreDataManager.shared.context

        context.perform {

            do {
                let news = NSEntityDescription.insertNewObject(forEntityName: "News", into: context)

                let headlineID = headline.objectID,
                headline = context.object(with: headlineID)

                news.setValue(headline, forKey: "headline")

                guard
                    let codingUserInfoContext = CodingUserInfoKey.context,
                    let codingUserInfoType = CodingUserInfoKey.type,
                    let codingUserInfoNews = CodingUserInfoKey.news
                    else {
                        DispatchQueue.main.async {
                            completionHandler(false)
                        }
                        return
                }

                let decoder = JSONDecoder()
                decoder.userInfo[codingUserInfoContext] = context
                decoder.userInfo[codingUserInfoNews] = news
                decoder.userInfo[codingUserInfoType] = Headline.Category.associated

                let newsContent = try decoder.decode(NewsContent.self, from: data)

                news.setValue(newsContent.topic?.text, forKey: "text")

                if let newsVideo = news.value(forKey: "video") as? NewsVideo {
                    newsVideo.setValue(newsContent.topic?.previewVideoImageURL, forKey: "imageURL")
                }

                try context.save()

                DispatchQueue.main.async {
                    completionHandler(true)
                }
            } catch let error as NSError {
                DispatchQueue.main.async {
                    completionHandler(false)
                }
                print("Method: CoreDataStorageManager.saveNews \nError: \(error.localizedDescription)")
            }

            CoreDataManager.shared.saveContext()
        }
    }

    static func changeFavoriteValueNews(_ news: News, completionHandler: @escaping () -> Void) {

        guard let isFavorite = news.value(forKey: "favorites") as? Bool else {
            completionHandler()
            return
        }

        news.setValue(!isFavorite, forKey: "favorites")

        try? CoreDataManager.shared.context.save()

        DispatchQueue.main.async {
            completionHandler()
        }
    }

    static func deleteHeadlines(category: Headline.Category,
                                completionHandler: @escaping () -> Void) {

        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.parent = CoreDataManager.shared.context

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Headline")
        fetchRequest.predicate = NSPredicate(format: "category == %@", category.rawValue)

        context.perform {
            do {
                let headlines = try context.fetch(fetchRequest) as? [Headline]

                headlines?.forEach({ headline in
                    context.delete(headline)
                })

                try context.save()
            } catch let error as NSError {
                print("Method: CoreDataStorageManager.deleteHeadlines \nError: \(error.localizedDescription)")
                completionHandler()
            }
            CoreDataManager.shared.saveContext()
            completionHandler()
        }
    }

    static func imagesURLsForHeadlines(category: Headline.Category,
                                       completionHandler: @escaping ([URL]?) -> Void) {

        let context = CoreDataManager.shared.privateQueueContext

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "HeadlineImageMetadata")
        fetchRequest.predicate = NSPredicate(format: "headline.category == %@", category.rawValue)
        fetchRequest.resultType = .dictionaryResultType
        fetchRequest.returnsDistinctResults = true
        fetchRequest.propertiesToFetch = ["url"]

        context.perform {
            do {
                guard let result = try context.fetch(fetchRequest) as? [[String: URL]] else {
                    completionHandler(nil)
                    return
                }

                var urls = [URL]()

                result.forEach({ object in
                    if let url = object["url"] {
                        urls.append(url)
                    }
                })

                completionHandler(urls)
                return
            } catch {
                completionHandler(nil)
                return
            }
        }
    }

}
