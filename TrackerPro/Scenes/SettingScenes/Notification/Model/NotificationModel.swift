//
//  NotificationModel.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 15.03.2023.
//

import Foundation

struct NotificationModel {
    var type: NotificationType
}

enum NotificationType {
    case admittance
    case reminderFrequency
}
