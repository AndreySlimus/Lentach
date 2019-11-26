//
//  LoadingEffectView.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//

import UIKit

class LoadingEffectView: UIView {

    // MARK: - Constants
    private struct Constants {

        static let startingAnimationLocation: [NSNumber] = [-1.0, -0.5, 0.0]
        static let endedAnimationLocation: [NSNumber] = [1.0, 1.5, 2.0]
        static let backgroundGradientColor = UIColor.white.withAlphaComponent(0.3).cgColor
        static let movingGradienColor = UIColor.white.withAlphaComponent(1.0).cgColor
        static let movingAnimationDuration: CFTimeInterval = 1.0
        static let delayBetweenAnimationLoops: CFTimeInterval = 0.3
    }

    // MARK: - Private Properties
    // MARK: -- UI Properties
    private var gradientLayer = CAGradientLayer()

    // MARK: - Lifecycle
    // MARK: -- Initializations
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupGradientLayer()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupGradientLayer()
    }

    // MARK: - Public Methods
    func startAnimating() {

        let animation = CABasicAnimation(keyPath: "locations")

        animation.fromValue = Constants.startingAnimationLocation
        animation.toValue = Constants.endedAnimationLocation
        animation.duration = Constants.movingAnimationDuration
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)

        let animationGroup = CAAnimationGroup()

        animationGroup.duration = Constants.movingAnimationDuration + Constants.delayBetweenAnimationLoops
        animationGroup.animations = [animation]
        animationGroup.repeatCount = .infinity

        self.gradientLayer.add(animationGroup, forKey: animation.keyPath)
    }

    func stopAnimating() {

        self.gradientLayer.removeAllAnimations()
    }

    // MARK: - Private Methods
    // MARK: -- Setup UI
    private func setupGradientLayer() {

        self.gradientLayer = CAGradientLayer()

        self.gradientLayer.frame = self.bounds
        self.gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        self.gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        self.gradientLayer.locations = Constants.startingAnimationLocation
        self.gradientLayer.colors = [
            UIColor.white.withAlphaComponent(0.3).cgColor,
            UIColor.white.withAlphaComponent(1.0).cgColor,
            UIColor.white.withAlphaComponent(0.3).cgColor
        ]

        self.layer.addSublayer(gradientLayer)
    }

}
