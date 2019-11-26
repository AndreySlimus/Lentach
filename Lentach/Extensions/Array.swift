//
//  Array.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation

extension Array where Element: Hashable {

    func difference(between array: [Element]) -> [Element] {
        let thisSet = Set(self)
        let otherSet = Set(array)
        return Array(thisSet.symmetricDifference(otherSet))
    }

}
