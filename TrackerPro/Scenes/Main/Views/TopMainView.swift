//
//  TopMainView.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 13.03.2023.
//

import UIKit

final class TopMainView: UIView {
    
    enum Flow {
        case showSetting
        case showSearch
    }
    
    private let settingView: CustomButton = {
        let vw = CustomButton()
        vw.image = ImageHelper.settingIcon.withTintColor(.systemGreen)
        vw.imageSize = .init(width: 25, height: 25)
        vw.imagePozitionType = .centerIcon
        vw.backgroundColor = ColorHelper.buttonColor
        vw.corner = 10
        return vw
    }()
    
    private let searchView: CustomButton = {
        let vw = CustomButton()
        vw.image = ImageHelper.searchIcon.withTintColor(.systemGreen)
        vw.imageSize = .init(width: 25, height: 25)
        vw.imagePozitionType = .centerIcon
        vw.backgroundColor = ColorHelper.buttonColor
        vw.corner = 10
        return vw
    }()
    
    var flow: ((Flow) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bindUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addConstraints()
    }
    
    private func bindUI() {
        settingView.tap = { [weak self] in
            guard let self = self else { return }
            self.flow?(.showSetting)
        }
        
        searchView.tap = { [weak self] in
            guard let self = self else { return }
            self.flow?(.showSearch)
        }
    }
    
    private func addConstraints() {
        addSubviews(
            settingView,
            searchView
        )
        
        settingView.snp.remakeConstraints { make in
            make.centerY.leading.equalToSuperview()
            make.size.equalTo(40)
        }
        
        searchView.snp.remakeConstraints { make in
            make.centerY.trailing.equalToSuperview()
            make.size.equalTo(40)
        }
    }
}




