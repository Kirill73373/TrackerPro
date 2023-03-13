//
//  MAinViewModel.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 12.03.2023.
//

import Foundation

final class MainViewModel {
    
    enum Flow {
        case back
        case showSetting
    }
    
    var flow: ((Flow) -> Void)?
}

