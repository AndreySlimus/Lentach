//
//  FileManager.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation

extension FileManager {

    open var documentDirectoryPath: URL? {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    }

}
