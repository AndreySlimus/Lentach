//
//  NavigationBar.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//

import UIKit

extension UINavigationBar {

    func setTransparency(_ transparency: Bool, animated: Bool) {

        if animated {
            UIView.animate(withDuration: 0.3) {
                self.setTransparency(transparency)
                self.layoutIfNeeded()
            }
        } else {
            self.setTransparency(transparency)
        }
    }

    func setTransparency(_ transparency: Bool) {

        switch transparency {
        case true:
            self.setBackgroundImage(UIImage(), for: .default)
            self.shadowImage = UIImage()
            self.isTranslucent = true
        case false:
            self.setBackgroundImage(nil, for: .default)
            self.shadowImage = nil
            self.isTranslucent = false
        }
    }

}
