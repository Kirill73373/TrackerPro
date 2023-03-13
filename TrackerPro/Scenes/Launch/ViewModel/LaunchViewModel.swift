//
//  LaunchViewModel.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 11.03.2023.
//

import Foundation

final class LaunchViewModel {
    
    enum Flow {
        case showOnboardVC
    }
    
    var flow: ((Flow) -> Void)?
}
