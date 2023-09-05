//
//  SceneDelegate.swift
//  CoinValueAppDraft
//
//  Created by Алексей Орловский on 29.08.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        window?.rootViewController = TabBarViewController()
    }
}

