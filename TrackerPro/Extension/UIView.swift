//
//  UIView.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 11.03.2023.
//

import UIKit

extension UIView {
    
    var height: CGFloat {
        get { return frame.size.height }
    }
    
    var width: CGFloat {
        get { return frame.size.width }
    }
    
    func addSubviews(_ view: UIView...) {
        view.forEach { view in
            addSubview(view)
        }
    }
    
    func appendShadow(color: UIColor, opacity: Float, radius: CGFloat, offset: CGSize, compositingFilter: Any? = nil) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shadowOffset = offset
    }
    
    @discardableResult
    func constrain(width: CGFloat, height: CGFloat) -> Self {
        self.snp.updateConstraints { make in
            make.height.equalTo(height)
            make.width.equalTo(width)
        }
        return self
    }
}

extension UIView {
    
    enum CornerType {
        case topLeft
        case topRight
        case bottomLeft
        case bottomRight
        case all
        case top
        case bottom
        case topLeftBottomRight
        case bottomLeftTopRight
    }
    
   func cornerType(type: CornerType, radius: CGFloat) {
        layer.cornerRadius = radius
        switch type {
        case .topLeft:
            layer.maskedCorners = [.layerMinXMinYCorner]
        case .topRight:
            layer.maskedCorners = [.layerMaxXMinYCorner]
        case .bottomLeft:
            layer.maskedCorners = [.layerMinXMaxYCorner]
        case .bottomRight:
            layer.maskedCorners = [.layerMaxXMaxYCorner]
        case .all:
            layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        case .top:
            layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        case .bottom:
            layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        case .topLeftBottomRight:
            layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        case .bottomLeftTopRight:
            layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner]
        }
    }
}
