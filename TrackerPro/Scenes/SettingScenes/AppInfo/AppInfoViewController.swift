//
//  AppInfoViewController.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 13.03.2023.
//

import UIKit

final class AppInfoViewController: UIViewController {
    
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
        setupStyleView()
        addConstraints()
    }
    
    private func setupStyleView() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
    }
    
    private func addConstraints() {
       // view.addSubview()
        
    }
}

