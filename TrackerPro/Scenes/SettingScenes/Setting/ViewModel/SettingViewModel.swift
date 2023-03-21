//
//  SettingViewModel.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 11.03.2023.
//

import Foundation
import UIKit

final class SettingViewModel {
    
    enum Flow {
        case showExchangeRates
        case showStatistic
        case showLanguage
        case showSubject
        case showChangeIcon
        case showPasscode
        case showCommands
        case showNotification
        case showSupport
        case showAppInfo
    }
    
    var flow: ((Flow) -> Void)?
    
    var items: [SettingModel] = [
        SettingModel(type: .title),
        SettingModel(type: .line),
        SettingModel(type: .paywall, lineType: .paywall),
        SettingModel(type: .line),
        SettingModel(title: "setting_cell_exchange_rates", image: ImageHelper.valuteIcon, type: .other, lineType: .valute),
        SettingModel(title: "setting_cell_statistic", image: ImageHelper.statisticIcon, type: .other, lineType: .statistic),
        SettingModel(type: .line),
        SettingModel(title: "setting_cell_language", image: ImageHelper.languageIcon, type: .other, lineType: .language),
        SettingModel(title: "setting_cell_subject", image: ImageHelper.subjectIcon, type: .other, lineType: .subject),
        SettingModel(title: "setting_cell_changeIcon", image: ImageHelper.widgetsIcon, type: .other, lineType: .changeIcon),
        SettingModel(type: .line),
        SettingModel(title: "setting_cell_passcode", image: ImageHelper.passwordIcon, type: .other, lineType: .passcode),
        SettingModel(title: "setting_cell_commands", image: ImageHelper.commandIcon, type: .other, lineType: .commands),
        SettingModel(title: "setting_cell_notification", image: ImageHelper.notificationIcon, type: .other, lineType: .notification),
        SettingModel(type: .line),
        SettingModel(title: "setting_cell_review", image: ImageHelper.reviewIcon, type: .other, lineType: .review),
        SettingModel(title: "setting_cell_support", image: ImageHelper.appIcon, type: .other, lineType: .support),
        SettingModel(title: "setting_cell_indo_app", image: ImageHelper.appInfoIcon, type: .other, lineType: .appInfo),
    ]
}

