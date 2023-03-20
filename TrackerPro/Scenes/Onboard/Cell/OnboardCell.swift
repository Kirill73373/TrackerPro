//
//  OnboardCell.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 11.03.2023.
//

import UIKit
import Lottie

final class OnboardCell: UICollectionViewCell {
    
    private let animationView: LottieAnimationView = {
        let vw = LottieAnimationView()
        vw.contentMode = .scaleAspectFit
        vw.loopMode = .loop
        vw.animationSpeed = 0.5
        return vw
    }()
    
    private let titleTextLabel: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 0
        lb.textColor = .black
        lb.textAlignment = .center
        lb.font = .systemFont(ofSize: 30, weight: .ultraLight)
        return lb
    }()
    
    private let textLabel: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 0
        lb.textColor = .black
        lb.textAlignment = .center
        lb.font = .systemFont(ofSize: 18, weight: .ultraLight)
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
    
    func configure(model: OnboardModel) {
        titleTextLabel.text = model.title
        textLabel.text = model.subTitle
        animationView.animation = .named(model.animationName)
        animationView.play()
    }
    
    private func setupCellStyle() {
        backgroundColor = .clear
    }
    
    private func addConstraints() {
        contentView.addSubviews(
            animationView,
            titleTextLabel,
            textLabel
        )
        
        titleTextLabel.snp.makeConstraints { make in
            make.centerX.equalTo(animationView)
            make.bottom.equalTo(animationView.snp.top).inset(-20)
            make.leading.trailing.equalToSuperview().inset(70)
        }
        
        animationView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 200, height: 200))
        }
        
        textLabel.snp.makeConstraints { make in
            make.centerX.equalTo(animationView)
            make.top.equalTo(animationView.snp.bottom).inset(-20)
            make.leading.trailing.equalToSuperview().inset(70)
        }
    }
}
