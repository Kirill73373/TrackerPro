//
//  SupportModel.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 14.03.2023.
//

import Foundation
import UIKit

struct SupportModel {
    var icon: UIImage
    var title: String
    var type: SupportType
}

enum SupportType {
    case vk
    case mail
    case telegram
    case whatApp
    case instagram
}
