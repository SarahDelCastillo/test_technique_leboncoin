//
//  SceneDelegate.swift
//  Test Leboncoin
//
//  Created by Sarah Del Castillo on 18/01/2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    private lazy var httpClient: HTTPClient = URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
    private lazy var feedLoader = RemoteFeedLoader(client: httpClient)

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: scene)
        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
    }

    lazy var navigationController = {
        let rootVC = HomeViewController()
        rootVC.loadWithFilter = feedLoader.loadWithFilter
        return UINavigationController(rootViewController: rootVC)
    }()
}

