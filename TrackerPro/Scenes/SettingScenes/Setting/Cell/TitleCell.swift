//
//  TitleCell.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 13.03.2023.
//

import UIKit

final class TitleCell: UICollectionViewCell {
    
    private let titleMyLabel: UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 40, weight: .regular)
        lb.textColor = ColorHelper.blackColor.withAlphaComponent(0.4)
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellStyle()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        activateLocalizedString()
    }
    
    private func activateLocalizedString() {
        titleMyLabel.text = "setting_title".localized()
    }
    
    private func setupCellStyle() {
        backgroundColor = .clear
    }
    
    private func addConstraints() {
        contentView.addSubviews(
            titleMyLabel
        )
        
        titleMyLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().inset(10)
        }
    }
}

