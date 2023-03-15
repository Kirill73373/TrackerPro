//
//  UserDefaultsHelper.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 12.03.2023.
//

import Foundation

final class UserDefaultsHelper {
    
    private enum UDKey: String {
        case isPay
        case isShowOnboard
        case isOnFaceId
        case isNotificationActive
        case isShowStickerActive
        case selectedIndex
        case selectedIndexLanguage
        case language
    }
    
    // MARK: - Public properties
    static let shared = UserDefaultsHelper()
    
    var isPay: Bool {
        get { getValue(.isPay ) as? Bool ?? false }
        set { setValue(newValue, key: .isPay) }
    }
    
    var isNotificationActive: Bool {
        get { getValue(.isNotificationActive ) as? Bool ?? false }
        set { setValue(newValue, key: .isNotificationActive) }
    }
    
    var isShowStickerActive: Bool {
        get { getValue(.isShowStickerActive ) as? Bool ?? false }
        set { setValue(newValue, key: .isShowStickerActive) }
    }
    
    var language: String {
        get { getValue(.language ) as? String ?? "ru" }
        set { setValue(newValue, key: .language) }
    }
    
    var selectedIndex: Int {
        get { getValue(.selectedIndex ) as? Int ?? 0 }
        set { setValue(newValue, key: .selectedIndex) }
    }
    
    var selectedIndexLanguage: Int {
        get { getValue(.selectedIndexLanguage ) as? Int ?? 0 }
        set { setValue(newValue, key: .selectedIndexLanguage) }
    }
    
    var isOnFaceId: Bool {
        get { getValue(.isOnFaceId ) as? Bool ?? false }
        set { setValue(newValue, key: .isOnFaceId) }
    }
    
    var isShowOnboard: Bool {
        get { getValue(.isShowOnboard ) as? Bool ?? false }
        set { setValue(newValue, key: .isShowOnboard) }
    }
    
    // MARK: - Private Properties
    
    private let suiteName = "TrackerPro"
    private lazy var userDefaults = UserDefaults(suiteName: suiteName)
    
    // MARK: - Private Methods
    
    private func setValue(_ value: Any, key: UDKey) {
        userDefaults?.set(value, forKey: key.rawValue)
        userDefaults?.synchronize()
    }
    
    private func getValue(_ key: UDKey) -> Any? {
        return userDefaults?.value(forKey: key.rawValue)
    }
}


