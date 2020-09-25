//
//  ViewController.swift
//  VK2
//
//  Created by Marat on 23.09.2020.
//  Copyright © 2020 Marat. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var loginView = LoginView()
    
    override func loadView() {
        view = loginView
    }
    
    override func viewDidLoad() {
        // Подписываемся на обновления
        NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        loginView.loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Отписываемся
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    @objc func loginButtonPressed() {
        let vc = UserProfileViewController()
        
        // Получаем входные данные
        guard let userName = loginView.loginInput.text, let userPassword = loginView.passwordInput.text else { return }

        // Авторизация
        UserSession.instance.login(userName: userName, userPassword: userPassword)
            self.present(vc, animated: true)

    }
    
    
    // MARK: Keyboard
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            loginView.contentInset = .zero
        } else {
            loginView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }
        
        loginView.scrollIndicatorInsets = loginView.contentInset
        loginView.layoutIfNeeded()
    }
    
    
    
    
}

