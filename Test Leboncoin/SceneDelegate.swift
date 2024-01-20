//
//  SceneDelegate.swift
//  Test Leboncoin
//
//  Created by Sarah Del Castillo on 18/01/2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: scene)
        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
    }

    lazy var navigationController = {
        let rootVC = HomeViewController()
        return UINavigationController(rootViewController: rootVC)
    }()
}

