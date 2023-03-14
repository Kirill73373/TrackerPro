//
//  SupportCell.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 11.03.2023.
//

import UIKit

final class SupportCell: UICollectionViewCell {
    
    private let containerOneView: UIView = {
        let vw = UIView()
        vw.backgroundColor = ColorHelper.bgColor
        vw.cornerType(type: .all, radius: 10)
        vw.appendShadow(color: UIColor(red: 1, green: 1, blue: 1, alpha: 1), opacity: 1, radius: 12, offset: CGSize(width: -4, height: -2))
        vw.clipsToBounds = false
        return vw
    }()
    
    private let containerTwoView: UIView = {
        let vw = UIView()
        vw.backgroundColor = ColorHelper.bgColor
        vw.cornerType(type: .all, radius: 10)
        vw.appendShadow(color: UIColor(red: 0.534, green: 0.646, blue: 0.749, alpha: 0.48), opacity: 1, radius: 12, offset: CGSize(width: 4, height: 2))
        vw.clipsToBounds = false
        return vw
    }()
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellStyle()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: SupportModel) {
        titleLabel.text = model.title
        iconImageView.image = model.icon
    }
    
    private func setupCellStyle() {
        backgroundColor = .clear
    }
    
    private func addConstraints() {
        contentView.addSubviews(
            containerOneView,
            containerTwoView
        )
        
        containerTwoView.addSubviews(
            iconImageView,
            titleLabel
        )
        
        containerOneView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview()
        }
        
        containerTwoView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview()
        }
        
        iconImageView.snp.makeConstraints { make in
            make.leading.centerY.equalToSuperview()
            make.size.equalTo(80)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(iconImageView.snp.trailing).inset(-15)
        }
    }
}
