//
//  NotificationViewModel.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 11.03.2023.
//

import Foundation

final class NotificationViewModel {
    
    enum Flow {
        case back
    }
    
    var flow: ((Flow) -> Void)?
    
    private(set) var items: [NotificationModel] = [
        NotificationModel(type: .admittance),
        NotificationModel(type: .reminderFrequency)
    ]
}

