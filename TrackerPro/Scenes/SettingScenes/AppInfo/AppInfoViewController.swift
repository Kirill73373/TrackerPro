//
//  AppInfoViewController.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 13.03.2023.
//

import UIKit

final class AppInfoViewController: UIViewController {
    
    private let backView: CustomButton = {
        let vw = CustomButton()
        vw.image = ImageHelper.backOtherIcon.withTintColor(ColorHelper.blackColor.withAlphaComponent(0.4))
        vw.imageSize = .init(width: 25, height: 25)
        vw.imagePozitionType = .centerIcon
        vw.backgroundColor = ColorHelper.buttonColor
        vw.corner = 10
        return vw
    }()
    
    private let titleLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = ColorHelper.blackColor.withAlphaComponent(0.4)
        lb.font = .systemFont(ofSize: 25, weight: .light)
        lb.text = "О приложении"
        return lb
    }()
    
    private let containerOneView = ContainerView()
    
    private let iconAppImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.image = ImageHelper.appLaunchIcon
        img.layer.borderWidth = 0.8
        img.layer.borderColor = ColorHelper.blackColor.withAlphaComponent(0.4).cgColor
        img.cornerType(type: .all, radius: 15)
        img.clipsToBounds = true
        return img
    }()
    
    private let nameAppLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = ColorHelper.blackColor.withAlphaComponent(0.6)
        lb.font = .systemFont(ofSize: 15, weight: .light)
        lb.text = "Name: \(Bundle.main.appName ?? "")"
        return lb
    }()
    
    private let buildLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = ColorHelper.blackColor.withAlphaComponent(0.6)
        lb.font = .systemFont(ofSize: 15, weight: .light)
        lb.text = "Build: \(Bundle.main.buildVersionNumber ?? "")"
        return lb
    }()
    
    private let versionLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = ColorHelper.blackColor.withAlphaComponent(0.6)
        lb.font = .systemFont(ofSize: 15, weight: .light)
        lb.text = "Version: \(Bundle.main.releaseVersionNumber ?? "")"
        return lb
    }()
    
    private let viewModel: AppInfoViewModel
    
    init(viewModel: AppInfoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
        setupStyleView()
        addConstraints()
    }
    
    private func bindUI() {
        backView.tap = { [weak self] in
            guard let self = self else { return }
            self.viewModel.flow?(.back)
        }
    }
    
    private func setupStyleView() {
        view.backgroundColor = ColorHelper.bgColor
        navigationController?.navigationBar.isHidden = true
    }
    
    private func addConstraints() {
        view.addSubviews(
            backView,
            titleLabel,
            containerOneView
        )
        
        containerOneView.addSubviews(
            iconAppImageView,
            nameAppLabel,
            buildLabel,
            versionLabel
        )
        
        backView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(60)
            make.size.equalTo(40)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(backView)
        }
        
        containerOneView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(backView.snp.bottom).inset(-40)
            make.height.equalTo(110)
        }
        
        iconAppImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(5)
            make.centerY.equalToSuperview()
            make.size.equalTo(100)
        }
        
        nameAppLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconAppImageView.snp.trailing).inset(-15)
            make.bottom.equalTo(buildLabel.snp.top).inset(-17)
        }
        
        buildLabel.snp.makeConstraints { make in
            make.centerY.equalTo(iconAppImageView)
            make.leading.equalTo(iconAppImageView.snp.trailing).inset(-15)
        }
        
        versionLabel.snp.makeConstraints { make in
            make.top.equalTo(buildLabel.snp.bottom).inset(-17)
            make.leading.equalTo(iconAppImageView.snp.trailing).inset(-15)
        }
    }
}
