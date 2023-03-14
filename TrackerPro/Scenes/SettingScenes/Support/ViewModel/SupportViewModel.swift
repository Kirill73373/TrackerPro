//
//  SupportViewModel.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 11.03.2023.
//

import Foundation
import UIKit

final class SupportViewModel {
    
    enum Flow {
        case back
    }
    
    var flow: ((Flow) -> Void)?
    
    private(set) var items: [SupportModel] = [
        SupportModel(icon: ImageHelper.telegramIcon, title: "Telegram", type: .telegram),
        SupportModel(icon: ImageHelper.instagramIcon, title: "Instagram", type: .instagram),
        SupportModel(icon: ImageHelper.whatsAppIcon, title: "WhatsApp", type: .whatApp),
        SupportModel(icon: ImageHelper.vkIcon, title: "VK", type: .vk),
        SupportModel(icon: ImageHelper.mailIcon, title: "Mail", type: .mail)
    ]
}

