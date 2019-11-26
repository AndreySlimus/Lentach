//
//  UINavigationItem.swift
//  Lentach
//
//  Created by Andrey Malaev on 00/00/00.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
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
