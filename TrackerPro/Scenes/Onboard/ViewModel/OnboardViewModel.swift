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
        .init(animationName: "myPetsAnimation", title: "one_title_onboard".localized(), subTitle: "one_subTitle_onboard".localized()),
        .init(animationName: "myPetsAnimation", title: "two_title_onboard".localized(), subTitle: "two_subTitle_onboard".localized()),
        .init(animationName: "myPetsAnimation", title: "three_title_onboard".localized(), subTitle: "three_subTitle_onboard".localized()),
        .init(animationName: "myPetsAnimation", title: "four_title_onboard".localized(), subTitle: "four_subTitle_onboard".localized())
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

