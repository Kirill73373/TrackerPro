//
//  ReminderFrequencyCell.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 15.03.2023.
//

import UIKit

final class ReminderFrequencyCell: UICollectionViewCell {
    
    private let containerOneView = ContainerView()
    
    private let iconAppImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.image = ImageHelper.appLaunchIcon
        img.layer.borderWidth = 0.8
        img.layer.borderColor = ColorHelper.blackColor.withAlphaComponent(0.2).cgColor
        img.cornerType(type: .all, radius: 15)
        img.clipsToBounds = true
        return img
    }()
    
    private let titleLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = ColorHelper.blackColor.withAlphaComponent(0.4)
        lb.font = .systemFont(ofSize: 18, weight: .light)
        lb.text = "notification_sticker".localized()
        return lb
    }()
    
    private let showLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = ColorHelper.blackColor.withAlphaComponent(0.4)
        lb.font = .systemFont(ofSize: 18, weight: .light)
        lb.text = "notification_show_sticker".localized()
        return lb
    }()
    
    private let redCircleLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = ColorHelper.whiteColor
        lb.backgroundColor = ColorHelper.redColor
        lb.font = .systemFont(ofSize: 13, weight: .light)
        lb.cornerType(type: .all, radius: 10)
        lb.textAlignment = .center
        lb.text = "1"
        lb.clipsToBounds = true
        return lb
    }()
    
    private let switchView = SwitchView()
    
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
        switchView.toogleSwitch(isActive: UserDefaultsHelper.shared.isShowStickerActive)
        redCircleLabel.isHidden = !UserDefaultsHelper.shared.isShowStickerActive
    }
    
    private func setupCellStyle() {
        backgroundColor = .clear
    }
    
    private func addConstraints() {
        contentView.addSubviews(
            containerOneView
        )
        
        containerOneView.addSubviews(
            titleLabel,
            iconAppImageView,
            redCircleLabel,
            showLabel,
            switchView
        )
        
        containerOneView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.leading.equalToSuperview().inset(15)
        }
        
        iconAppImageView.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview().inset(5)
            make.size.equalTo(CGSize(width: 100, height: 100))
        }
        
        redCircleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(iconAppImageView.snp.top).inset(15)
            make.leading.equalTo(iconAppImageView.snp.trailing).inset(15)
            make.size.equalTo(20)
        }
        
        showLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconAppImageView.snp.trailing).inset(-15)
            make.centerY.equalTo(iconAppImageView)
        }
        
        switchView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(15)
            make.centerY.equalTo(iconAppImageView)
            make.size.equalTo(CGSize(width: 51, height: 30))
        }
    }
}
