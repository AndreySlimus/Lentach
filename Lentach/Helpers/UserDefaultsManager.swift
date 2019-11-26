//
//  UserDefaultsManager.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation

class UserDefaultsManager {

    // MARK: - Static Properties
    // MARK: -- Public
    static var dateLatestUpdateHeadlines: Date? {
        return UserDefaults.standard.value(forKey: ConstantKeys.dateLatestUpdateHeadlinesKey) as? Date
    }

    // MARK: - Static Methods
    // MARK: -- Public
    static func rewriteDateLatestUpdateHeadlines() {

        UserDefaults.standard.setValue(Date(), forKey: ConstantKeys.dateLatestUpdateHeadlinesKey)
    }

    // MARK: - Constants
    private struct ConstantKeys {

        static let dateLatestUpdateHeadlinesKey = "lastDateUpdateHeadlines"
    }

}
