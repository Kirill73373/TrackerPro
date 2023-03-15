//
//  ContainerView.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 15.03.2023.
//

import UIKit

final class ContainerView: UIView {
    
    private let containerOneView: UIView = {
        let vw = UIView()
        vw.backgroundColor = ColorHelper.bgColor
        vw.cornerType(type: .all, radius: 10)
        vw.appendShadow(color: UIColor(red: 1, green: 1, blue: 1, alpha: 1), opacity: 1, radius: 8, offset: CGSize(width: -4, height: -2))
        vw.clipsToBounds = false
        return vw
    }()
    
    private let containerTwoView: UIView = {
        let vw = UIView()
        vw.backgroundColor = ColorHelper.bgColor
        vw.cornerType(type: .all, radius: 10)
        vw.appendShadow(color: UIColor(red: 0.534, green: 0.646, blue: 0.749, alpha: 0.48), opacity: 1, radius: 8, offset: CGSize(width: 4, height: 2))
        vw.clipsToBounds = false
        return vw
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        addSubviews(
            containerOneView,
            containerTwoView
        )
        
        containerOneView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerTwoView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
