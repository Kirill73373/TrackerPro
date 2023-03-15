//
//  LanguageCell.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 11.03.2023.
//

import UIKit

final class LanguageCell: UICollectionViewCell {
    
    private let containerOneView = ContainerView()
    
    private let iconImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.cornerType(type: .all, radius: 4)
        img.clipsToBounds = true
        return img
    }()
    
    private let titleLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = ColorHelper.blackColor.withAlphaComponent(0.4)
        lb.font = .systemFont(ofSize: 20, weight: .light)
        return lb
    }()
    
    private let selectedView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.image = ImageHelper.selectedIcon
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellStyle()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func selectedCell(_ isSelected: Bool) {
        selectedView.alpha = isSelected ? 1 : 0
    }
    
    func configure(model: LanguageModel) {
        iconImageView.image = model.icon
        titleLabel.text = model.title
    }
    
    private func setupCellStyle() {
        backgroundColor = .clear
    }
    
    private func addConstraints() {
        contentView.addSubviews(
            containerOneView
        )
        
        containerOneView.addSubviews(
            iconImageView,
            titleLabel,
            selectedView
        )
        
        containerOneView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview()
        }
        
        selectedView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(15)
            make.centerY.equalToSuperview()
            make.size.equalTo(32)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(10)
            make.size.equalTo(CGSize(width: 50, height: 34))
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(iconImageView)
            make.leading.equalTo(iconImageView.snp.trailing).inset(-15)
        }
    }
}
