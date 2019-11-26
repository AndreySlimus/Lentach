//
//  DatePreparer.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation

class DatePreparer {

    // MARK: - Static Property
    // MARK: -- Private
    private static let dateFormatter: DateFormatter = {

        let formatter = DateFormatter()
        formatter.dateFormat = Constants.standardDateFormat
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale.init(identifier: Constants.standardLocale)

        return formatter
    }()

    // MARK: - Static Methods
    // MARK: -- Public
    static func dateStringSince1970(_ seconds: TimeInterval,
                                    dateFormat format: String = Constants.standardDateFormat) -> String {

        self.dateFormatter.dateFormat = format

        let date = Date.init(timeIntervalSince1970: seconds)

        return self.dateFormatter.string(from: date).lowercased()
    }

    static func dateString(_ date: Date,
                           dateFormat format: String = Constants.standardDateFormat) -> String {

        self.dateFormatter.dateFormat = format

        return self.dateFormatter.string(from: date).lowercased()
    }

    // MARK: - Constants
    private struct Constants {

        static let standardDateFormat = "HH:mm, d MMMM yyyy, EEEE"
        static let standardLocale = "ru_BY"
    }

}
