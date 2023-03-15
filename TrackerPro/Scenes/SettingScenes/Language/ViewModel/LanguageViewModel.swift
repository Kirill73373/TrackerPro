//
//  LanguageViewModel.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 11.03.2023.
//

import Foundation

final class LanguageViewModel {
    
    enum Flow {
        case back
    }
    
    var flow: ((Flow) -> Void)?
    
    private(set) var items: [LanguageModel] = [
        LanguageModel(icon: ImageHelper.russiaIcon, title: "Русский", lang: "ru"),
        LanguageModel(icon: ImageHelper.serbiyaIcon, title: "Српски", lang: "sr"),
        LanguageModel(icon: ImageHelper.belarusIcon, title: "Беларускі", lang: "be"),
        LanguageModel(icon: ImageHelper.ukreinIcon, title: "Український", lang: "uk"),
        LanguageModel(icon: ImageHelper.englandIcon, title: "English", lang: "en"),
        LanguageModel(icon: ImageHelper.germanyIcon, title: "Deutsch", lang: "de"),
        LanguageModel(icon: ImageHelper.japanIcon, title: "日本", lang: "ja"),
        LanguageModel(icon: ImageHelper.chinaIcon, title: "中国人", lang: "zh-Hant")
    ]
}

