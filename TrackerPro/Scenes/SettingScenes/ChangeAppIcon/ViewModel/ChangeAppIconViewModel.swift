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
        ChangeAppIconModel(icon: ImageHelper.green, title: "Green"),
        ChangeAppIconModel(icon: ImageHelper.blue, title: "Blue"),
        ChangeAppIconModel(icon: ImageHelper.purple, title: "Purple"),
        ChangeAppIconModel(icon: ImageHelper.red, title: "Red"),
        ChangeAppIconModel(icon: ImageHelper.gold, title: "Gold"),
        ChangeAppIconModel(icon: ImageHelper.black, title: "Black")
    ]
}

