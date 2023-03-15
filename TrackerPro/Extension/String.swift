//
//  String.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 15.03.2023.
//

import Foundation

extension String {
    
    func localized() -> String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.localizedBundle(), value: "", comment: "")
    }
    
    func localizeWithFormat(arguments: CVarArg...) -> String{
        return String(format: self.localized(), arguments: arguments)
    }
}

extension Bundle {
    private static var bundle: Bundle?
    
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
