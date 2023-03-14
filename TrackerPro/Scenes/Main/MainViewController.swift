//
//  MainController.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 12.03.2023.
//

import UIKit
import Lottie

final class MainViewController: UIViewController {
    
    private let topMainView = TopMainView()
    
    private let viewModel: MainViewModel
    
    init(viewModel: MainViewModel) {
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
        topMainView.flow = { [weak self] type in
            guard let self = self else { return }
            switch type {
            case .showSetting:
                self.viewModel.flow?(.showSetting)
            case .showSearch:
                self.viewModel.flow?(.showSetting)
            }
        }
    }
    
    private func setupStyleView() {
        view.backgroundColor = ColorHelper.bgColor
        navigationController?.navigationBar.isHidden = true
    }
    
    private func addConstraints() {
        view.addSubviews(
            topMainView
        )
        
        topMainView.snp.remakeConstraints { make in
            make.trailing.leading.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(50)
            make.height.equalTo(40)
        }
    }
}
