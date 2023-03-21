//
//  ChangeAppIconViewModel.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 11.03.2023.
//

import Foundation

final class ChangeAppIconViewModel {
    
    enum Flow {
        case back
    }
    
    var flow: ((Flow) -> Void)?
    
    private(set) var items: [ChangeAppIconModel] = [
        ChangeAppIconModel(icon: ImageHelper.green, title: "change_icon_color_green"),
        ChangeAppIconModel(icon: ImageHelper.blue, title: "change_icon_color_blue"),
        ChangeAppIconModel(icon: ImageHelper.purple, title: "change_icon_color_purple"),
        ChangeAppIconModel(icon: ImageHelper.red, title: "change_icon_color_red"),
        ChangeAppIconModel(icon: ImageHelper.gold, title: "change_icon_color_gold"),
        ChangeAppIconModel(icon: ImageHelper.black, title: "change_icon_color_black")
    ]
}

