//
//  HTMLDecoder.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation

class HTMLDecoder {

    // MARK: - Static Properties
    // MARK: -- Private
    private static let HTMLSymbols = "<a href"

    // MARK: - Static Methods
    // MARK: -- Public
    static func isContainHTML(_ string: String) -> Bool {
        return string.range(of: HTMLSymbols) != nil ? true : false
    }

    static func removeHTML(_ string: String) -> String {

        return string.replacingOccurrences(of: "<[^>]+>",
                                           with: "",
                                           options: .regularExpression,
                                           range: nil)
    }

}
