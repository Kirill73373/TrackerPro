//
//  AnaliticService.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 14.03.2023.
//

import YandexMobileMetrica
import Foundation
import UIKit

final class AnaliticService: NSObject {
    
    static let shared = AnaliticService()
    
    func analiticInstallations() {
        guard let configuration = YMMYandexMetricaConfiguration.init(apiKey: "ef8fb85a-13d1-4173-9fa1-62662bd7d67b") else { return }
        YMMYandexMetrica.activate(with: configuration)
    }
}
