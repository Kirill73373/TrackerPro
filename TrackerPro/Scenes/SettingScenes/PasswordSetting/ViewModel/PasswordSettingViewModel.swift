//
//  PasswordSettingViewModel.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 22.03.2023.
//

import Foundation

final class PasswordSettingViewModel {
    
    enum Flow {
        case back
    }
    
    var flow: ((Flow) -> Void)?
    
    private(set) var cellViewModels = [CellBaseViewModelProtocol]() {
        didSet {
           
        }
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> CellBaseViewModelProtocol {
        return cellViewModels[indexPath.row]
    }
    
    func appendCell() {
        cellViewModels = [
            EnablePasswordCellViewModel(),
            EnablePasswordCellViewModel()
        ]
    }
}
