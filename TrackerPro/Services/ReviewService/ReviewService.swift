//
//  ReviewService.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 14.03.2023.
//

import Foundation
import UIKit

final class ReviewService {
        
    static func review(id: String) {
        guard let url = URL(string: "itms-apps:itunes.apple.com/us/app/apple-store/id\(id)?mt=8&action=write-review") else { return }
        UIApplication.shared.open(url)
    }
}
