//
//  SettingCell.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 11.03.2023.
//

import UIKit

final class OtherCell: UICollectionViewCell {
    
    private let iconImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    private let titleMyLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = ColorHelper.greenColor
        lb.font = .systemFont(ofSize: 15, weight: .light)
        return lb
    }()
    
    private let arrowImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.image = ImageHelper.arrowIcon.withTintColor(ColorHelper.greenColor)
        return img
    }()
    
    private let lineView: UIView = {
        let vw = UIView()
        vw.backgroundColor = ColorHelper.greenColor.withAlphaComponent(0.25)
        return vw
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
        iconImageView.image = model.image?.withTintColor(ColorHelper.greenColor)
        titleMyLabel.text = model.title
    }
    
    private func setupCellStyle() {
        backgroundColor = .clear
    }
    
    private func addConstraints() {
        contentView.addSubviews(
            iconImageView,
            titleMyLabel,
            arrowImageView,
            lineView
        )
        
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(10)
            make.size.equalTo(21)
        }
        
        titleMyLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(iconImageView.snp.trailing).inset(-15)
        }
        
        arrowImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(10)
            make.size.equalTo(10)
        }
        
        lineView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview()
            make.height.equalTo(0.4)
        }
    }
}
