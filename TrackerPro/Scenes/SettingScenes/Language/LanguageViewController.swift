//
//  LanguageViewController.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 11.03.2023.
//

import UIKit

final class LanguageViewController: UIViewController {
    
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
        lb.text = "language_title".localized()
        return lb
    }()
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.registerCells(LanguageCell.self)
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        collection.showsVerticalScrollIndicator = false
        collection.contentInsetAdjustmentBehavior = .never
        collection.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 40, right: 0)
        return collection
    }()
    
    private let viewModel: LanguageViewModel
    
    init(viewModel: LanguageViewModel) {
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
        collectionView.delegate = self
        collectionView.dataSource = self
        view.backgroundColor = ColorHelper.bgColor
        navigationController?.navigationBar.isHidden = true
    }
    
    private func addConstraints() {
        view.addSubviews(
            backView,
            titleLabel,
            collectionView
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
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(backView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension LanguageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UIImpactFeedbackGenerator(style: .soft).impactOccurred(intensity: 0.7)
        let model = viewModel.items[indexPath.row]
        UserDefaultsHelper.shared.selectedIndexLanguage = indexPath.row
        Bundle.setLanguage(lang: model.lang)
        titleLabel.text = "language_title".localized()
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LanguageCell", for: indexPath) as? LanguageCell else { return UICollectionViewCell() }
        let model = viewModel.items[indexPath.row]
        cell.configure(model: model)
        cell.selectedCell(UserDefaultsHelper.shared.selectedIndexLanguage == indexPath.row)
        return cell
    }
}
