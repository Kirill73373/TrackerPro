//
//  SettingCell.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 11.03.2023.
//

import UIKit

final class OtherCell: UICollectionViewCell {
    
    private let containerOneView: UIView = {
        let vw = UIView()
        vw.backgroundColor = ColorHelper.bgColor
        vw.cornerType(type: .all, radius: 5)
        vw.appendShadow(color: UIColor(red: 1, green: 1, blue: 1, alpha: 1), opacity: 1, radius: 5, offset: CGSize(width: -4, height: -2))
        vw.clipsToBounds = false
        return vw
    }()
    
    private let containerTwoView: UIView = {
        let vw = UIView()
        vw.backgroundColor = ColorHelper.bgColor
        vw.cornerType(type: .all, radius: 5)
        vw.appendShadow(color: UIColor(red: 0.534, green: 0.646, blue: 0.749, alpha: 0.48), opacity: 1, radius: 5, offset: CGSize(width: 4, height: 2))
        vw.clipsToBounds = false
        return vw
    }()
    
    private let iconImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    private let titleMyLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = ColorHelper.blackColor.withAlphaComponent(0.4)
        lb.font = .systemFont(ofSize: 15, weight: .light)
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
    
    func configure(model: SettingModel) {
        iconImageView.image = model.image?.withTintColor(ColorHelper.blackColor.withAlphaComponent(0.4))
        titleMyLabel.text = model.title
    }
    
    private func setupCellStyle() {
        backgroundColor = .clear
    }
    
    private func addConstraints() {
        contentView.addSubviews(
            containerOneView,
            containerTwoView,
            titleMyLabel
        )
        
        containerTwoView.addSubviews(
            iconImageView
        )
        
        containerOneView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(10)
            make.size.equalTo(30)
        }
        
        containerTwoView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(10)
            make.size.equalTo(30)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.size.equalTo(21)
        }
        
        titleMyLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(iconImageView.snp.trailing).inset(-15)
        }
    }
}
