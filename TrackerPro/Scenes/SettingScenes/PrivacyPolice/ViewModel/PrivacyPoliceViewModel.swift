//
//  PrivacyPoliceViewModel.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 11.03.2023.
//

import Foundation

final class PrivacyPoliceViewModel {
    
    enum Flow {
        case back
    }
    
    var flow: ((Flow) -> Void)?
}

