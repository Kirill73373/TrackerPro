//
//  SettingViewController.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 11.03.2023.
//

import UIKit

final class SettingViewController: UIViewController {
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.registerCells(TitleCell.self, PayCell.self, OtherCell.self, LineCell.self)
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        collection.showsVerticalScrollIndicator = false
        collection.contentInsetAdjustmentBehavior = .never
        collection.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        return collection
    }()
    
    private let viewModel: SettingViewModel
    
    init(viewModel: SettingViewModel) {
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
        collectionView.delegate = self
        collectionView.dataSource = self
        view.backgroundColor = ColorHelper.bgColor
        navigationController?.navigationBar.isHidden = true
    }
    
    private func addConstraints() {
        view.addSubviews(
            collectionView
        )
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension SettingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        let model = viewModel.items[indexPath.row]
        switch model.type {
        case .title:
            return CGSize(width: size.width, height: 100)
        case .paywall:
            return CGSize(width: size.width, height: 150)
        case .other:
            return CGSize(width: size.width, height: 40)
        case .line:
            return CGSize(width: size.width, height: 30)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = viewModel.items[indexPath.row]
        guard model.type != .title && model.type != .line else { return }
        UIImpactFeedbackGenerator(style: .soft).impactOccurred(intensity: 0.7)
        switch model.lineType {
        case .paywall:
            print("paywall")
        case .valute:
            print("valute")
        case .statistic:
            print("statistic")
        case .language:
            print("language")
        case .subject:
            print("subject")
        case .widgets:
            print("widgets")
        case .passcode:
            print("passcode")
        case .commands:
            print("commands")
        case .notification:
            print("notification")
        case .review:
            print("review")
        case .support:
            print("support")
        case .appInfo:
            print("appInfo")
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = viewModel.items[indexPath.row]
        switch model.type {
        case .title:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TitleCell", for: indexPath) as? TitleCell else { return UICollectionViewCell() }
            return cell
        case .paywall:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PayCell", for: indexPath) as? PayCell else { return UICollectionViewCell() }
            return cell
        case .other:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OtherCell", for: indexPath) as? OtherCell else { return UICollectionViewCell() }
            cell.configure(model: model)
            return cell
        case .line:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LineCell", for: indexPath) as? LineCell else { return UICollectionViewCell() }
            return cell
       
        }
    }
}

