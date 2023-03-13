//
//  PageView.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 12.03.2023.
//

import UIKit

final class PageView: UIView {
    
    var spasing: CGFloat = 4
    var activeSize: CGSize = .init(width: 8, height: 8)
    var notActiveSize: CGSize = .init(width: 12, height: 6)
    var activeCorner: CGFloat = 4
    var notActiveCorner: CGFloat = 3
    var activeColor: UIColor = ColorHelper.whiteColor
    var notActiveColor: UIColor = ColorHelper.blackColor
    
    private lazy var containerStackView: UIStackView = {
        let stc = UIStackView()
        stc.alignment = .center
        stc.distribution = .fillProportionally
        return stc
    }()
    
    init(axis: NSLayoutConstraint.Axis) {
        super.init(frame: .zero)
        containerStackView.axis = axis
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerStackView.spacing = spasing
    }
    
    func getIndex(_ index: Int) {
        containerStackView.arrangedSubviews.forEach { view in
            if index == view.tag {
                UIView.animate(withDuration: 0.5) {
                    view.constrain(width: self.activeSize.width, height: self.activeSize.height)
                    view.backgroundColor = self.activeColor
                    view.layer.cornerRadius = self.activeCorner
                    view.superview?.layoutIfNeeded()
                }
            } else {
                UIView.animate(withDuration: 0.5) {
                    view.constrain(width: self.notActiveSize.width, height: self.notActiveSize.height)
                    view.backgroundColor = self.notActiveColor
                    view.layer.cornerRadius = self.notActiveCorner
                    view.superview?.layoutIfNeeded()
                }
            }
        }
    }
    
    func setStackViews(_ quantity: Int) {
        for i in 0...(quantity - 1) {
            setStackViews(index: i)
        }
    }
    
    private func setStackViews(index: Int) {
        let cellView = UIView()
        cellView.tag = index
        if index == 0 {
            cellView.constrain(width: activeSize.width, height: activeSize.height)
            cellView.backgroundColor = activeColor
            cellView.layer.cornerRadius = activeCorner
        } else {
            cellView.constrain(width: notActiveSize.width, height: notActiveSize.height)
            cellView.backgroundColor = self.notActiveColor
            cellView.layer.cornerRadius = notActiveCorner
        }
        containerStackView.addArrangedSubview(cellView)
    }
    
    private func addConstraints() {
        addSubview(
            containerStackView
        )
        
        containerStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}


