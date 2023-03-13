//
//  BottomOnboardView.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 12.03.2023.
//

import UIKit

final class TrailingOnboardView: UIView {
    
    enum Flow {
        case back
        case next
    }
    
    private let backView: CustomButton = {
        let vw = CustomButton()
        vw.image = ImageHelper.backIcon.withTintColor(.systemGreen)
        vw.imageSize = .init(width: 25, height: 25)
        vw.imagePozitionType = .centerIcon
        vw.backgroundColor = ColorHelper.buttonColor
        vw.corner = 15
        vw.isHidden = true
        return vw
    }()
    
    private let pageView: PageView = {
        let pg = PageView(axis: .vertical)
        pg.activeSize = .init(width: 3, height: 95)
        pg.notActiveSize = .init(width: 3, height: 32)
        pg.activeCorner = 1.5
        pg.notActiveCorner = 1.5
        pg.spasing = 10
        pg.activeColor = .systemGreen
        pg.notActiveColor = .systemGreen.withAlphaComponent(0.2)
        return pg
    }()
    
    private let nextView: CustomButton = {
        let vw = CustomButton()
        vw.image = ImageHelper.nextIcon.withTintColor(.systemGreen)
        vw.imageSize = .init(width: 25, height: 25)
        vw.imagePozitionType = .centerIcon
        vw.backgroundColor = ColorHelper.buttonColor
        vw.corner = 15
        return vw
    }()
    
    var flow: ((Flow) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bindUI()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setStackViews(_ count: Int) {
        pageView.setStackViews(count)
    }
    
    func getIndexPage(_ index: Int) {
        pageView.getIndex(index)
        animationBackButton(index)
    }
    
    private func animationBackButton(_ index: Int) {
        if index == 1 {
            self.backView.isHidden = false
            UIView.animate(withDuration: 0.8, delay: 0) {
                self.backView.snp.remakeConstraints { make in
                    make.centerX.equalToSuperview()
                    make.bottom.equalTo(self.nextView.snp.top).inset(-10)
                    make.size.equalTo(60)
                }
                self.backView.superview?.layoutIfNeeded()
            }
        } else if index == 0 {
            UIView.animate(withDuration: 0.8, delay: 0) {
                self.backView.snp.remakeConstraints { make in
                    make.trailing.equalToSuperview().inset(-100)
                    make.bottom.equalTo(self.nextView.snp.top).inset(-10)
                    make.size.equalTo(60)
                }
                self.backView.superview?.layoutIfNeeded()
            }
        }
    }
    
    private func bindUI() {
        backView.tap = { [weak self] in
            guard let self = self else { return }
            self.flow?(.back)
        }
        
        nextView.tap = { [weak self] in
            guard let self = self else { return }
            self.flow?(.next)
        }
    }
    
    private func addConstraints() {
        addSubviews(
            pageView,
            backView,
            nextView
        )
        
        backView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(-100)
            make.bottom.equalTo(nextView.snp.top).inset(-10)
            make.size.equalTo(60)
        }
        
        pageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview()
        }
       
        nextView.snp.makeConstraints { make in
            make.centerX.bottom.equalToSuperview()
            make.size.equalTo(60)
        }
    }
}
