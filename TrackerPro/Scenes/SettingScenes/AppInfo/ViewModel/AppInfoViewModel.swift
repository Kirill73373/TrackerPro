//
//  AppInfoViewModel.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 13.03.2023.
//

import Foundation

final class AppInfoViewModel {
    
    enum Flow {
        case back
    }
    
    var flow: ((Flow) -> Void)?
}


