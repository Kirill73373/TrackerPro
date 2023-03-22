//
//  PasswordSettingCell.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 22.03.2023.
//

import UIKit

final class EnablePasswordCell: UICollectionViewCell, CellProtocol {    
    
    var viewModel: CellBaseViewModelProtocol? {
        didSet {
            print("sknvskdvkj")
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellStyle()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCellStyle() {
        backgroundColor = .clear
    }
    
    private func addConstraints() {
        contentView.addSubviews(
        )
    }
}
