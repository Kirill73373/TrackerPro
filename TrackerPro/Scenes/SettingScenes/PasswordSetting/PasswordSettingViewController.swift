//
//  PasswordSettingViewController.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 22.03.2023.
//

import UIKit

final class PasswordSettingViewController: UIViewController {
    
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
        lb.text = "Пароль"
        return lb
    }()
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.registerCells(EnablePasswordCell.self)
        collection.backgroundColor = .clear
        collection.showsVerticalScrollIndicator = false
        collection.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 40, right: 0)
        return collection
    }()
    
    private let viewModel: PasswordSettingViewModel
    
    init(viewModel: PasswordSettingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.appendCell()
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

extension PasswordSettingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width, height: 60)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.cellViewModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = viewModel.getCellViewModel(at: indexPath)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: model.identifier, for: indexPath)
        cell.viewModel(model)
        return cell
    }
}
