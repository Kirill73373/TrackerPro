//
//  UICollectionViewCell.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 22.03.2023.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    
    func viewModel(_ model: any CellBaseViewModelProtocol) {
        guard var cell = self as? CellProtocol else { return }
        cell.viewModel = model
    }
}

