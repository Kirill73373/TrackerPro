//
//  SceneDelegate.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 11.03.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var appCoordinator = AppCoordinator()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = appCoordinator.rootViewController
        window?.makeKeyAndVisible()
        appCoordinator.start()
    }
}
