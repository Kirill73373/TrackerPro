//
//  AlertViewModel.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 12.03.2023.
//

import Foundation

final class AlertViewModel {
    
    enum Flow {
        case back
        case enter
        case swipeClose
    }
    
    var flow: ((Flow) -> Void)?
    var model: AlertModel? 
}


