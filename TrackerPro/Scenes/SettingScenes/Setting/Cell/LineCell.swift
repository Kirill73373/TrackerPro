//
//  LineCell.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 13.03.2023.
//

import UIKit

final class LineCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCellStyle() {
        backgroundColor = .clear
    }
}
