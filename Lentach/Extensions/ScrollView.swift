//
//  ScrollView.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//

import UIKit

extension UIScrollView {

    func changeColorVerticalScrollIndicator(to color: UIColor) {

        guard let verticalScrollIndicator = self.subviews.last as? UIImageView else { return }
        verticalScrollIndicator.backgroundColor = color
    }

}
