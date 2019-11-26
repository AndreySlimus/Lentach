//
//  ImagesFileManager.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//

import UIKit

class ImagesFileManager {

    // MARK: - Private Static Properties
    private static let directoryName = "Images"

    private static let directoryPath: String? = {
        return FileManager.default.documentDirectoryPath?.appendingPathComponent(directoryName).path
    }()

    // MARK: - Private Static Functions
    private static func createImagePath(_ imageName: String) -> String? {

        guard let directoryPath = self.directoryPath as NSString? else { return nil }

        return directoryPath.appendingPathComponent(imageName.createPath)
    }

    private static func removeImage(atPath path: String) {

        guard let imagePath = createImagePath(path) else { return }

        try? FileManager.default.removeItem(atPath: imagePath)
    }

    private static func removeImages(atPaths paths: [String]) {

        paths.forEach { removeImage(atPath: $0) }

    }

    // MARK: - Public Static Functions
    static func createDirectory() {

        guard let path = self.directoryPath else { return }

        if !FileManager.default.fileExists(atPath: path) {
            try? FileManager.default.createDirectory(atPath: path,
                                                     withIntermediateDirectories: true,
                                                     attributes: nil)
        }
    }

    static func save(_ image: UIImage, atPath path: String) {

        guard
            let imageData = image.jpegData(compressionQuality: 1.0),
            let imagePath = createImagePath(path)
            else {
                return
        }

        FileManager.default.createFile(atPath: imagePath,
                                       contents: imageData,
                                       attributes: nil)
    }

    static func load(atPath path: String) -> UIImage? {

        guard let imagePath = createImagePath(path) else { return nil }

        if FileManager.default.fileExists(atPath: imagePath) {
            return UIImage.init(contentsOfFile: imagePath)
        } else {
            return nil
        }
    }

    static func updateDirectory(newURLs urls: [URL]) {

        guard
            let directoryPath = directoryPath,
            let oldPaths = try? FileManager.default.contentsOfDirectory(atPath: directoryPath)
            else {
                return
        }

        var newPaths = [String]()

        urls.forEach { url in
            newPaths.append(url.absoluteString.createPath)
        }

        let deletePaths = oldPaths.difference(between: newPaths)

        removeImages(atPaths: deletePaths)
    }

}
