//
//  UICollectionView.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 12.03.2023.
//

import Foundation
import UIKit

extension UICollectionView {
    
    func scroll(row: Int) {
        let indexPath = IndexPath(row: row, section: 0)
        scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
    }
    
    func registerCells(_ cell: UIView.Type...) {
        cell.forEach {
            register($0.self, forCellWithReuseIdentifier: String(describing: $0))
        }
    }
}
