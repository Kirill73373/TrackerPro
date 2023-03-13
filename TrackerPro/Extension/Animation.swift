//
//  Animation.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 11.03.2023.
//

import Foundation
import UIKit

extension UIView {
    
    func usingSpringWithDampingAnimation(withDuration: CGFloat = 1, usingSpringWithDamping: CGFloat = 1, delay: CGFloat = 0.5, completionAnimate: (() -> Void)?, completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: withDuration, delay: delay, usingSpringWithDamping: usingSpringWithDamping, initialSpringVelocity: 8, options: [.curveEaseInOut, .allowUserInteraction, .curveLinear]) {
            completionAnimate?()
        } completion: { _ in
            completion?()
        }
    }
    
    func rotateWithAnimation(angle: CGFloat, duration: CGFloat? = nil) {
        let pathAnimation = CABasicAnimation(keyPath: "transform.rotation")
        pathAnimation.duration = CFTimeInterval(duration ?? 1.0)
        pathAnimation.fromValue = 0
        pathAnimation.toValue = angle
        pathAnimation.repeatCount = .infinity
        pathAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        transform = transform.rotated(by: angle)
        layer.add(pathAnimation, forKey: "transform.rotation")
    }
}
