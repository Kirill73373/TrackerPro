//
//  SwitchView.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 15.03.2023.
//

import Foundation
import UIKit

final class SwitchView: UIView {
    
    private let squareView: UIView = {
        let vw = UIView()
        vw.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor
        vw.layer.shadowOpacity = 1
        vw.layer.shadowRadius = 8
        vw.layer.shadowOffset = CGSize(width: 0, height: 3)
        return vw
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        styleView()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 4
        squareView.layer.cornerRadius = 4
    }
    
    func toogleSwitch(isActive: Bool) {
        if !isActive {
            UIView.animate(withDuration: 0.3) {
                self.squareView.snp.remakeConstraints { make in
                    make.leading.equalToSuperview().inset(1)
                    make.centerY.equalToSuperview()
                    make.size.equalTo(27)
                }
                self.backgroundColor = ColorHelper.blackColor.withAlphaComponent(0.05)
                self.squareView.backgroundColor = ColorHelper.whiteColor
                self.squareView.superview?.layoutIfNeeded()
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.squareView.snp.remakeConstraints { make in
                    make.trailing.equalToSuperview().inset(1)
                    make.centerY.equalToSuperview()
                    make.size.equalTo(27)
                }
                self.backgroundColor = ColorHelper.greenColor
                self.squareView.backgroundColor = ColorHelper.whiteColor
                self.squareView.superview?.layoutIfNeeded()
            }
        }
    }
    
    private func styleView() {
        backgroundColor = .clear
    }
    
    private func addConstraints() {
        addSubview(squareView)
        
        squareView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(1)
            make.centerY.equalToSuperview()
            make.size.equalTo(27)
        }
    }
}
