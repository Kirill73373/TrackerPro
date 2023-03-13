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
        case back
    }
    
    var flow: ((Flow) -> Void)?
    
    var items: [SettingModel] = [
        SettingModel(type: .title),
        SettingModel(type: .line),
        SettingModel(type: .paywall, lineType: .paywall),
        SettingModel(type: .line),
        SettingModel(title: "Курс валют", image: ImageHelper.valuteIcon, type: .other, lineType: .valute),
        SettingModel(title: "Статистика", image: ImageHelper.statisticIcon, type: .other, lineType: .statistic),
        SettingModel(type: .line),
        SettingModel(title: "Язык", image: ImageHelper.languageIcon, type: .other, lineType: .language),
        SettingModel(title: "Тема", image: ImageHelper.subjectIcon, type: .other, lineType: .subject),
        SettingModel(title: "Виджеты", image: ImageHelper.widgetsIcon, type: .other, lineType: .widgets),
        SettingModel(type: .line),
        SettingModel(title: "Пароль", image: ImageHelper.passwordIcon, type: .other, lineType: .passcode),
        SettingModel(title: "Команды", image: ImageHelper.commandIcon, type: .other, lineType: .commands),
        SettingModel(title: "Уведомления", image: ImageHelper.notificationIcon, type: .other, lineType: .notification),
        SettingModel(type: .line),
        SettingModel(title: "Оставить отзыв", image: ImageHelper.reviewIcon, type: .other, lineType: .review),
        SettingModel(title: "Техподдержка", image: ImageHelper.appIcon, type: .other, lineType: .support),
        SettingModel(title: "О приложении", image: ImageHelper.appInfoIcon, type: .other, lineType: .appInfo),
    ]
}

