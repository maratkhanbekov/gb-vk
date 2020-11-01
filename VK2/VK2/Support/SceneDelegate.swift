//
//  SceneDelegate.swift
//  VK2
//
//  Created by Marat on 23.09.2020.
//  Copyright © 2020 Marat. All rights reserved.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
                
        window.makeKeyAndVisible()
        self.window = window
        window.rootViewController = UINavigationController(rootViewController: LoginVKViewController())
    }
}

