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
        ChangeAppIconModel(icon: ImageHelper.appLaunchIcon, title: "1"),
        ChangeAppIconModel(icon: ImageHelper.appLaunchIcon, title: "2"),
        ChangeAppIconModel(icon: ImageHelper.appLaunchIcon, title: "3"),
        ChangeAppIconModel(icon: ImageHelper.appLaunchIcon, title: "4"),
        ChangeAppIconModel(icon: ImageHelper.appLaunchIcon, title: "5"),
        ChangeAppIconModel(icon: ImageHelper.appLaunchIcon, title: "6"),
        ChangeAppIconModel(icon: ImageHelper.appLaunchIcon, title: "7"),
        ChangeAppIconModel(icon: ImageHelper.appLaunchIcon, title: "8"),
        ChangeAppIconModel(icon: ImageHelper.appLaunchIcon, title: "9"),
        ChangeAppIconModel(icon: ImageHelper.appLaunchIcon, title: "10")
    ]
}

