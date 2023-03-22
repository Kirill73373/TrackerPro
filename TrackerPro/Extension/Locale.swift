//
//  Locale.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 22.03.2023.
//

import Foundation

extension Locale {
    
    static var language: String {
        return Locale.current.languageCode ?? "en"
    }
}
