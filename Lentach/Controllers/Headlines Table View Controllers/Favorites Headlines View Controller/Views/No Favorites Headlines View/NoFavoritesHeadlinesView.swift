//
//  NoFavoritesHeadlinesView.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//

import UIKit

class NoFavoritesHeadlinesView: UIView {

    // MARK: - Class Methods
    class func instanceFromNib() -> NoFavoritesHeadlinesView? {

        let nib = UINib(nibName: "NoFavoritesHeadlinesView", bundle: nil)

        guard let view = nib.instantiate(withOwner: nil,
                                         options: nil).first as? NoFavoritesHeadlinesView
            else {
                return nil
        }

        return view
    }

}
