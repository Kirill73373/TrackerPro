//
//  LaunchViewController.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 11.03.2023.
//

import UIKit
import SnapKit

final class LaunchViewController: UIViewController {
    
    private let iconImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.image = ImageHelper.appLaunchIcon
        return img
    }()
    
    private let titleLabel: UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 15, weight: .ultraLight)
        lb.text = "Tracker PRO"
        lb.textColor = ColorHelper.blackColor
        return lb
    }()
    
    private let viewModel: LaunchViewModel
    
    init(viewModel: LaunchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStyleView()
        addConstraints()
        startAnimationIcon()
    }
    
    private func startAnimationIcon() {
        iconImageView.usingSpringWithDampingAnimation(withDuration: 2, usingSpringWithDamping: 2) { [weak self] in
            guard let self = self else { return }
            self.iconImageView.frame.origin.y = self.view.height / 1.5
            self.titleLabel.frame.origin.x = self.view.height / 1.5
        } completion: { [weak self] in
            guard let self = self else { return }
            self.viewModel.flow?(.showOnboardVC)
        }
    }
    
    private func setupStyleView() {
        view.backgroundColor = ColorHelper.bgColor
        navigationController?.navigationBar.isHidden = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    private func addConstraints() {
        view.addSubviews(
            iconImageView,
            titleLabel
        )
        
        iconImageView.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 200, height: 200))
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(30)
        }
    }
}
