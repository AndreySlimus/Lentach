//
//  View.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//

import UIKit

extension UIView {

    func addContainerSubview(_ view: UIView) {

        self.addSubview(view)

        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor),
            self.leftAnchor.constraint(equalTo: view.leftAnchor),
            self.rightAnchor.constraint(equalTo: view.rightAnchor),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func addRoundedLayers(_ views: [UIView]) {

        let roundedPath = CGMutablePath()
        let maskLayer = CAShapeLayer()

        views.forEach { view in

            guard self.subviews.contains(view) else {
                print("View:\(view) is not a subview of \(self). Therefore, it cannot be a masking view.")
                return
            }

            roundedPath.addRoundedRect(in: view.frame,
                                       cornerWidth: view.frame.size.height / 2,
                                       cornerHeight: view.frame.size.height / 2)
        }

        maskLayer.path = roundedPath

        self.layer.mask = maskLayer
    }

}
