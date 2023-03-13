//
//  AlertController.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 12.03.2023.
//

import UIKit
import SnapKit
import Lottie

final class AlertController: BottomSheetController {
    
    private let animationView: LottieAnimationView = {
        let vw = LottieAnimationView()
        vw.contentMode = .scaleAspectFit
        vw.loopMode = .loop
        vw.animationSpeed = 0.5
        return vw
    }()
    
    private let containeView: UIView = {
        let vw = UIView()
        vw.cornerType(type: .all, radius: 15)
        vw.backgroundColor = ColorHelper.bgColor
        vw.appendShadow(color: UIColor(red: 0.534, green: 0.646, blue: 0.749, alpha: 0.48), opacity: 1, radius: 16, offset: CGSize(width: 4, height: 2))
        return vw
    }()
    
    private let titleLabel: UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 22, weight: .light)
        lb.textColor = ColorHelper.blackColor
        lb.textAlignment = .center
        lb.numberOfLines = 0
        return lb
    }()
    
    private let subTitleLabel: UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 15, weight: .light)
        lb.textColor = ColorHelper.blackColor.withAlphaComponent(0.7)
        lb.textAlignment = .center
        lb.numberOfLines = 0
        return lb
    }()
    
    private let leadingView: CustomButton = {
        let vw = CustomButton()
        vw.imagePozitionType = .notIcon
        vw.bgColor = ColorHelper.redColor
        vw.font = .systemFont(ofSize: 13, weight: .light)
        vw.corner = 10
        return vw
    }()
    
    private let separatorView: UIView = {
        let vw = UIView()
        return vw
    }()
    
    private let trailingView: CustomButton = {
        let vw = CustomButton()
        vw.imagePozitionType = .notIcon
        vw.bgColor = ColorHelper.greenColor
        vw.font = .systemFont(ofSize: 13, weight: .light)
        vw.corner = 10
        return vw
    }()
    
    private let viewModel: AlertViewModel
    
    init(viewModel: AlertViewModel) {
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
        leadingView.tap = { [weak self] in
            guard let self = self else { return }
            self.viewModel.flow?(.back)
        }
        
        trailingView.tap = { [weak self] in
            guard let self = self else { return }
            self.viewModel.flow?(.enter)
        }
        
        closeVC = { [weak self] in
            guard let self = self else { return }
            self.viewModel.flow?(.swipeClose)
        }
    }
    
    private func setupStyleView() {
        animationView.animation = .named(viewModel.model?.animationName ?? "")
        titleLabel.text = viewModel.model?.title ?? ""
        subTitleLabel.text = viewModel.model?.subTitle ?? ""
        leadingView.text = viewModel.model?.leftTitleButton ?? "CANCEL"
        trailingView.text = viewModel.model?.rightTitleButton ?? "ENTER"
        navigationController?.navigationBar.isHidden = true
        animationView.play()
    }

    private func addConstraints() {
        view.addSubviews(
            containeView,
            separatorView,
            trailingView,
            leadingView
        )
        
        containeView.addSubviews(
            animationView,
            titleLabel,
            subTitleLabel
        )
        
        containeView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(viewModel.model?.height ?? 100)
            make.bottom.equalTo(trailingView.snp.top).inset(-10)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(40)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-15)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        animationView.snp.makeConstraints { make in
            make.size.equalTo(70)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(-45)
        }
        
        leadingView.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.leading.equalToSuperview().inset(30)
            make.trailing.equalTo(separatorView.snp.leading).inset(-5)
            make.bottom.equalToSuperview().inset(30)
        }
        
        separatorView.snp.makeConstraints { make in
            make.centerX.equalTo(containeView)
            make.top.equalTo(containeView.snp.bottom)
            make.size.equalTo(0.5)
        }
        
        trailingView.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.trailing.equalToSuperview().inset(30)
            make.leading.equalTo(separatorView.snp.trailing).inset(-5)
            make.bottom.equalToSuperview().inset(30)
        }
    }
}

