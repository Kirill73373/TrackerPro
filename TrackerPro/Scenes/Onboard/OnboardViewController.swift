//
//  OnboardViewController.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 11.03.2023.
//

import UIKit

final class OnboardViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 35, weight: .ultraLight)
        lb.text = "Tracker PRO"
        lb.textColor = ColorHelper.blackColor
        return lb
    }()
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.registerCells(OnboardCell.self)
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        collection.showsVerticalScrollIndicator = false
        collection.contentInsetAdjustmentBehavior = .never
        collection.isScrollEnabled = false
        return collection
    }()
    
    private let trailingView = TrailingOnboardView()
    
    private let viewModel: OnboardViewModel
    
    init(viewModel: OnboardViewModel) {
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
        addSwipeGesture()
    }
    
    private func bindUI() {
        trailingView.flow = { [weak self] type in
            guard let self = self else { return }
            switch type {
            case .back:
                guard self.viewModel.index != 0 else { return }
                self.viewModel.index -= 1
                self.collectionView.scroll(row: self.viewModel.index)
                self.trailingView.getIndexPage(self.viewModel.index)
            case .next:
                guard self.viewModel.index != self.viewModel.items.count - 1 else {
                    self.viewModel.flow?(.showAlertCreatePasscode)
                    return
                }
                self.viewModel.index += 1
                self.collectionView.scroll(row: self.viewModel.index)
                self.trailingView.getIndexPage(self.viewModel.index)
            }
        }
    }
    
    private func addSwipeGesture() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeRight.direction = .up
        view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeLeft.direction = .down
        view.addGestureRecognizer(swipeLeft)
    }
    
    @objc private func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case .down:
                guard viewModel.index != 0 else { return }
                viewModel.index -= 1
                collectionView.scroll(row: viewModel.index)
                trailingView.getIndexPage(viewModel.index)
            case .up:
                guard viewModel.index != viewModel.items.count - 1 else {
                    return
                }
                viewModel.index += 1
                collectionView.scroll(row: viewModel.index)
                trailingView.getIndexPage(viewModel.index)
            default:
                break
            }
        }
    }
    
    private func setupStyleView() {
        trailingView.setStackViews(viewModel.items.count)
        collectionView.delegate = self
        collectionView.dataSource = self
        view.backgroundColor = ColorHelper.bgColor
        navigationController?.navigationBar.isHidden = true
    }
    
    private func addConstraints() {
        view.addSubviews(
            titleLabel,
            collectionView,
            trailingView
        )
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(50)
        }
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        trailingView.snp.makeConstraints { make in
            make.bottom.top.equalToSuperview().inset(50)
            make.trailing.equalToSuperview().inset(20)
            make.width.equalTo(60)
        }
    }
}

extension OnboardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardCell", for: indexPath) as? OnboardCell else { return UICollectionViewCell() }
        let viewModel = viewModel.items[indexPath.row]
        cell.configure(model: viewModel)
        return cell
    }
}
