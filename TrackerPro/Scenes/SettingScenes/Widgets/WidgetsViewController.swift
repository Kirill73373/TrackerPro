//
//  WidgetsViewController.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 11.03.2023.
//

import UIKit

final class WidgetsViewController: UIViewController {
    
    private let viewModel: WidgetsViewModel
    
    init(viewModel: WidgetsViewModel) {
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
        
    }
    
    private func setupStyleView() {
        view.backgroundColor = ColorHelper.bgColor
        navigationController?.navigationBar.isHidden = true
    }
    
    private func addConstraints() {
       // view.addSubview()
        
    }
}

