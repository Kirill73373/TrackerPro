//
//  UIColor.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 11.03.2023.
//

import Foundation
import UIKit

extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 255) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: a/255)
    }
}
