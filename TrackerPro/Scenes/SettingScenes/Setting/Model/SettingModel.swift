//
//  SettingModel.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 13.03.2023.
//

import Foundation
import UIKit

struct SettingModel {
    var title: String?
    var image: UIImage?
    var type: SettingCellType
    var lineType: LineType?
}

enum SettingCellType {
    case title
    case paywall
    case other
    case line
}

enum LineType: Int {
    case paywall = 0
    case valute = 1
    case statistic = 2
    case language = 3
    case subject = 4
    case changeIcon = 5
    case passcode = 6
    case commands = 7
    case notification = 8
    case review = 9
    case support = 10
    case appInfo = 11
}
