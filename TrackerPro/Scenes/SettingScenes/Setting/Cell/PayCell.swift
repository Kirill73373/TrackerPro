//
//  PaywallCell.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 13.03.2023.
//

import UIKit
import Lottie

final class PayCell: UICollectionViewCell {
    
    private let containerView: UIView = {
        let vw = UIView()
        vw.backgroundColor = ColorHelper.greenColor.withAlphaComponent(0.2)
        vw.cornerType(type: .all, radius: 10)
        vw.appendShadow(color: ColorHelper.greenColor, opacity: 1, radius: 6, offset: CGSize(width: 0, height: 0))
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
        lb.textColor = ColorHelper.whiteColor
        lb.font = .systemFont(ofSize: 15, weight: .regular)
        lb.text = "ПОВЫСИТЬ УРОВЕНЬ"
        return lb
    }()
    
    private let proLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = ColorHelper.whiteColor
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
            containerView
        )
        
        containerView.addSubviews(
            titleMyLabel,
            animationView,
            proLabel
        )
        
        containerView.snp.makeConstraints { make in
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

