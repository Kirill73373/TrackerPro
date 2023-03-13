//
//  PaywallCell.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 11.03.2023.
//

import UIKit

final class PaywallCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellStyle()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
     func configure(model: OnboardSceneModel) {
         bigImage.image = model.image
     }
     */
    
    private func setupCellStyle() {
        backgroundColor = .clear
    }
    
    private func addConstraints() {
       // contentView.addSubview()
    }
}
