//
//  OnboardViewModel.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 11.03.2023.
//

import Foundation

final class OnboardViewModel {
    
    enum Flow {
        case back
        case showAlertCreatePasscode
    }
    
    var index = 0
    var flow: ((Flow) -> Void)?
    
    private(set) var items: [OnboardModel] = [
        .init(animationName: "myPetsAnimation", title: "Cost Accounting", subTitle: "Control your spending \nin our app"),
        .init(animationName: "myPetsAnimation", title: "Revenue Accounting", subTitle: "Control your income in \nour application"),
        .init(animationName: "myPetsAnimation", title: "Access To Icloud", subTitle: "Synchronize your data \nwith your other \ndevices"),
        .init(animationName: "myPetsAnimation", title: "Section Of Debts", subTitle: "Our application has a \nsection of debts")
    ]
    
    func scrollToItem(isLeft: Bool, isTouch: Bool, complition: () -> Void) {
        let maxCount = items.count - 1
        if isLeft {
            if index != maxCount {
                index += 1
                complition()
            } else {
                if isTouch {
                   // AppUserDefaults.shared.isShowOnboard = true
                   // flow?(.showAuthorizationVC)
                }
            }
        } else {
            if index != 0 {
                index -= 1
                complition()
            }
        }
    }
}

