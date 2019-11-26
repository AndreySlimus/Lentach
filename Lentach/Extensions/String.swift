//
//  String.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation

extension String {

    static private(set) var paragraphSeparator = "\n\n"

    var createPath: String {
        return self.replacingOccurrences(of: "[/:]", with: "-", options: .regularExpression)
    }

    var siteAddress: String {

        var result = String()

        guard let rangeDoubleSlash = self.range(of: "://")?.upperBound else { return self }

        result = String.init(self[rangeDoubleSlash..<self.endIndex])

        guard let rangeOneSlash = result.range(of: "/")?.lowerBound else { return result }

        result = String.init(result[self.startIndex..<rangeOneSlash])

        return result
    }

}
