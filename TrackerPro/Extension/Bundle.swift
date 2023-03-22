//
//  Bundle.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 13.03.2023.
//

import Foundation
import UIKit

extension Bundle {
    
    private static var bundle: Bundle?
    
    var appName: String? {
        return infoDictionary?["CFBundleName"] as? String
    }
    
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
    
    public var icon: UIImage? {
        if let icons = infoDictionary?["CFBundleIcons"] as? [String: Any],
           let primaryIcon = icons["CFBundlePrimaryIcon"] as? [String: Any],
           let iconFiles = primaryIcon["CFBundleIconFiles"] as? [String],
           let lastIcon = iconFiles.last {
            return UIImage(named: lastIcon)
        }
        return nil
    }

    public static func localizedBundle() -> Bundle {
        if bundle == nil {
            let appLang = UserDefaultsHelper.shared.language
            let path = Bundle.main.path(forResource: appLang, ofType: "lproj")
            bundle = Bundle(path: path ?? "")
        }
        return bundle ?? Bundle()
    }
    
    public static func setLanguage(lang: String) {
        UserDefaultsHelper.shared.language = lang
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        bundle = Bundle(path: path ?? "")
    }
}
