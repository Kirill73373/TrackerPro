//
//  ChangeAppIconCell.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 11.03.2023.
//

import UIKit

final class ChangeAppIconCell: UICollectionViewCell {
    
    private let containerOneView = ContainerView()
    
    private let iconImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.cornerType(type: .all, radius: 10)
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
    
    func configure(model: ChangeAppIconModel) {
        titleLabel.text = model.title
        iconImageView.image = model.icon
    }
    
    func selectedCell(_ isSelected: Bool) {
        selectedView.alpha = isSelected ? 1 : 0
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
            make.edges.equalToSuperview()
        }
        
        selectedView.snp.makeConstraints { make in
            make.trailing.top.equalToSuperview().inset(7)
            make.size.equalTo(32)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(20)
            make.size.equalTo(80)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(iconImageView.snp.bottom).inset(-15)
        }
    }
}
