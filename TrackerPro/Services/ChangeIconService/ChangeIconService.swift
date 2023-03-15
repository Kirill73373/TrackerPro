//
//  ChangeIconService.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 15.03.2023.
//

import Foundation
import UIKit

final class ChangeIconService {
    
    static func setIcon(_ name: String) {
        UIApplication.shared.setAlternateIconName(name) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
