//
//  NavigationItem.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//

import UIKit

extension UINavigationItem {

    func deleteTitleBackButton() {

        self.backBarButtonItem = UIBarButtonItem(title: "",
                                                 style: .plain,
                                                 target: nil,
                                                 action: nil)
    }

}
