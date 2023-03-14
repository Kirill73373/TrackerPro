//
//  PaywallCell.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 13.03.2023.
//

import UIKit
import Lottie

final class PayCell: UICollectionViewCell {
    
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
    
    private let animationView: LottieAnimationView = {
        let vw = LottieAnimationView(name: "myPetsAnimation")
        vw.contentMode = .scaleAspectFit
        vw.loopMode = .loop
        vw.animationSpeed = 0.5
        vw.play()
        return vw
    }()
    
    private let titleMyLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = ColorHelper.greenColor
        lb.font = .systemFont(ofSize: 15, weight: .regular)
        lb.text = "ПОВЫСИТЬ УРОВЕНЬ"
        return lb
    }()
    
    private let proLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = ColorHelper.greenColor
        lb.font = .systemFont(ofSize: 20, weight: .regular)
        lb.text = "PRO"
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
    
    private func setupCellStyle() {
        backgroundColor = .clear
    }
    
    private func addConstraints() {
        contentView.addSubviews(
            containerOneView,
            containerTwoView
        )
        
        containerTwoView.addSubviews(
            titleMyLabel,
            animationView,
            proLabel
        )
        
        containerOneView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.bottom.equalToSuperview()
        }
        
        containerTwoView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.bottom.equalToSuperview()
        }
        
        titleMyLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(10)
        }
        
        animationView.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview()
            make.size.equalTo(CGSize(width: 100, height: 100))
        }
        
        proLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}

