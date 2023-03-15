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
        LanguageModel(icon: ImageHelper.russiaIcon, title: "Русский"),
        LanguageModel(icon: ImageHelper.serbiyaIcon, title: "Српски"),
        LanguageModel(icon: ImageHelper.belarusIcon, title: "Беларускі"),
        LanguageModel(icon: ImageHelper.ukreinIcon, title: "Український"),
        LanguageModel(icon: ImageHelper.englandIcon, title: "English"),
        LanguageModel(icon: ImageHelper.germanyIcon, title: "Deutsch"),
        LanguageModel(icon: ImageHelper.japanIcon, title: "日本"),
        LanguageModel(icon: ImageHelper.chinaIcon, title: "中国人")
    ]
}

