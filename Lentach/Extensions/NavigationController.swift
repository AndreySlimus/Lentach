//
//  NavigationController.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//

import UIKit

extension UINavigationController {

    /// Return last view controller in array navigationController.viewControllers
    var lastViewController: UIViewController? {
        return self.viewControllers.last
    }

}
