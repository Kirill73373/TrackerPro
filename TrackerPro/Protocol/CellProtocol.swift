//
//  CellProtocol.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 22.03.2023.
//

import Foundation
import UIKit

protocol CellProtocol {
    var viewModel: CellBaseViewModelProtocol? { get set }
}
