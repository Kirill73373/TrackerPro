//
//  AppColorViewModel.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 11.03.2023.
//

import Foundation

final class AppColorViewModel {
    
    enum Flow {
        case back
    }
    
    var flow: ((Flow) -> Void)?
}

