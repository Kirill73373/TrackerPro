//
//  AppCoordinator.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 11.03.2023.
//

import Foundation
import UIKit
import LGSideMenuController

final class AppCoordinator: NSObject {
        
    let navigationController = UINavigationController()
    private var sideMenuController: LGSideMenuController?
        
    var rootViewController: UIViewController {
        return navigationController
    }
        
    func start() {
        showLaunchVC()
    }
        
    private func showLaunchVC() {
        let viewModel = LaunchViewModel()
        let viewController = LaunchViewController(viewModel: viewModel)
        bindLaunchVC(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: false)
    }
    
    private func bindLaunchVC(viewModel: LaunchViewModel) {
        viewModel.flow = { [weak self] flow in
            guard let self = self else { return }
            switch flow {
            case .showOnboardVC:
                self.showOnboardVC()
            }
        }
    }
    
    private func showOnboardVC() {
        let viewModel = OnboardViewModel()
        let viewController = OnboardViewController(viewModel: viewModel)
        bindOnboardVC(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: false)
    }
    
    private func bindOnboardVC(viewModel: OnboardViewModel) {
        viewModel.flow = { [weak self] flow in
            guard let self = self else { return }
            switch flow {
            case .back:
                break
            case .showAlertCreatePasscode:
                self.showAlertCreatePasscodeVC()
            }
        }
    }
    
    private func showAlertCreatePasscodeVC() {
        let viewModel = AlertViewModel()
        viewModel.model = AlertModel(
            animationName: "passcodeLock",
            title: "Enable password?",
            subTitle: "By enabling a password, you will secure your content inside the application.",
            height: 160
        )
        let viewController = AlertController(viewModel: viewModel)
        viewController.preferredSheetSizing = UIScreen.main.bounds.height
        bindAlertCreatePasscodeVC(viewModel: viewModel)
        navigationController.present(viewController, animated: true)
    }
    
    private func bindAlertCreatePasscodeVC(viewModel: AlertViewModel) {
        viewModel.flow = { [weak self] flow in
            guard let self = self else { return }
            switch flow {
            case .back:
                self.navigationController.dismiss(animated: true) {
                    self.showMainVC()
                }
            case .enter:
                self.navigationController.dismiss(animated: true) {
                    print("Auth")
                }
            case .swipeClose:
                self.showMainVC()
            }
        }
    }
    
    private func showMainVC() {
        let viewModel = MainViewModel()
        let viewController = MainViewController(viewModel: viewModel)
        sideMenuController = LGSideMenuController(
            rootViewController: viewController,
            leftViewController: showSettingsVC()
        )
        sideMenuController?.rootViewLayerShadowColor = .clear
        sideMenuController?.delegate = self
        sideMenuController?.leftViewPresentationStyle = .scaleFromBig
        sideMenuController?.leftViewBackgroundColor = ColorHelper.bgColor
        sideMenuController?.leftViewWidth = viewController.view.frame.width / 1.5
        bindMainVC(viewModel: viewModel)
        navigationController.viewControllers.removeAll()
        navigationController.interactivePopGestureRecognizer?.isEnabled = true
        navigationController.pushViewController(sideMenuController ?? LGSideMenuController(), animated: false)
    }
    
    private func bindMainVC(viewModel: MainViewModel) {
        viewModel.flow = { [weak self] flow in
            guard let self = self else { return }
            switch flow {
            case .back:
                break
            case .showSetting:
                self.sideMenuController?.showLeftView()
            }
        }
    }
    
    private func showSettingsVC() -> UIViewController {
        let viewModel = SettingViewModel()
        let viewController = SettingViewController(viewModel: viewModel)
        bindSettingsVC(viewModel: viewModel)
        return viewController
    }
    
    private func bindSettingsVC(viewModel: SettingViewModel) {
        viewModel.flow = { [weak self] flow in
            guard let self = self else { return }
            switch flow {
            case .showExchangeRates:
                break
            case .showStatistic:
                break
            case .showLanguage:
                self.showLanguageVC()
            case .showSubject:
                break
            case .showChangeIcon:
                self.showChangeAppIconVC()
            case .showPasscode:
                break
            case .showCommands:
                break
            case .showNotification:
                self.showNotificationVC()
            case .showAppInfo:
                self.showAppInfoVC()
            case .showSupport:
                self.showSupportVC()
            }
        }
    }
    
    private func showLanguageVC() {
        let viewModel = LanguageViewModel()
        let viewController = LanguageViewController(viewModel: viewModel)
        bindLanguageVC(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func bindLanguageVC(viewModel: LanguageViewModel) {
        viewModel.flow = { [weak self] flow in
            guard let self = self else { return }
            switch flow {
            case .back:
                self.navigationController.popViewController(animated: true)
            }
        }
    }
    
    private func showChangeAppIconVC() {
        let viewModel = ChangeAppIconViewModel()
        let viewController = ChangeAppIconViewController(viewModel: viewModel)
        bindChangeAppIconVC(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func bindChangeAppIconVC(viewModel: ChangeAppIconViewModel) {
        viewModel.flow = { [weak self] flow in
            guard let self = self else { return }
            switch flow {
            case .back:
                self.navigationController.popViewController(animated: true)
            }
        }
    }
    
    private func showNotificationVC() {
        let viewModel = NotificationViewModel()
        let viewController = NotificationViewController(viewModel: viewModel)
        bindNotificationVC(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func bindNotificationVC(viewModel: NotificationViewModel) {
        viewModel.flow = { [weak self] flow in
            guard let self = self else { return }
            switch flow {
            case .back:
                self.navigationController.popViewController(animated: true)
            }
        }
    }
    
    private func showSupportVC() {
        let viewModel = SupportViewModel()
        let viewController = SupportViewController(viewModel: viewModel)
        bindSupportVC(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func bindSupportVC(viewModel: SupportViewModel) {
        viewModel.flow = { [weak self] flow in
            guard let self = self else { return }
            switch flow {
            case .back:
                self.navigationController.popViewController(animated: true)
            }
        }
    }
    
    private func showAppInfoVC() {
        let viewModel = AppInfoViewModel()
        let viewController = AppInfoViewController(viewModel: viewModel)
        bindAppInfoVC(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func bindAppInfoVC(viewModel: AppInfoViewModel) {
        viewModel.flow = { [weak self] flow in
            guard let self = self else { return }
            switch flow {
            case .back:
                self.navigationController.popViewController(animated: true)
            }
        }
    }
}

extension AppCoordinator: LGSideMenuDelegate {
    
    func didTransformLeftView(sideMenuController: LGSideMenuController, percentage: CGFloat) {
        if percentage > 0 {
            UIView.animate(withDuration: 0.3, delay: 0) {
                sideMenuController.rootView?.cornerType(type: .all, radius: 30)
                sideMenuController.rootView?.backgroundColor = ColorHelper.whiteColor
            }
        } else {
            UIView.animate(withDuration: 0.3, delay: 0) {
                sideMenuController.rootView?.cornerType(type: .all, radius: 0)
                sideMenuController.rootView?.backgroundColor = ColorHelper.bgColor
            }
        }
    }
    
    func didTransformRootView(sideMenuController: LGSideMenuController, percentage: CGFloat) {}
    func didTransformRightView(sideMenuController: LGSideMenuController, percentage: CGFloat) {}
}
