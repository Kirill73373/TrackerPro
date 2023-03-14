//
//  SupportService.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 14.03.2023.
//

import Foundation
import MessageUI
import UIKit

final class SupportService: NSObject {
    
    enum SupportSocialType {
        case vk
        case telegram
        case instagram
        case whatsApp
        case mail
        
        var urlString: String {
            switch self {
            case .vk:
                return "https://vk.com/id358572279"
            case .telegram:
                return "https://t.me/kirill_blokhin"
            case .instagram:
                return "https://www.instagram.com/kirill.blokhin_"
            case .whatsApp:
                return "https://api.whatsapp.com/send?phone=+79278084384"
            case .mail:
                return "blokhin-2024@inbox.ru"
            }
        }
    }
    
    static let shared = SupportService()
    
    func openSupportSocial(type: SupportSocialType) {
        if type != .mail {
            guard let url = URL(string: type.urlString) else { return }
            UIApplication.shared.open(url)
        } else {
            sendEmail(mailCopy: type.urlString)
        }
    }
    
    private func sendEmail(mailCopy: String) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([mailCopy])
            mail.setMessageBody("<p>Опишите вашу проблему</p>", isHTML: true)
            guard let rootViewController = UIApplication.shared.windows.last?.rootViewController else { return }
            rootViewController.present(mail, animated: true)
        } else {
            print("Error show sendEmail")
        }
    }
}

extension SupportService: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
