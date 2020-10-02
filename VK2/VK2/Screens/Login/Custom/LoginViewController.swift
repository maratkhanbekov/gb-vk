import UIKit
import WebKit

class LoginViewController: UIViewController {
    
    let weatherService = WeatherService()
    var loginView = LoginView()
    
    var webView = WKWebView()
    
    override func loadView() {
//        view = loginView
        
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
//        webView.uiDelegate = self
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        // Подписываемся на обновления
        NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        loginView.loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        
        // MARK: Weather
//         callback - кусок кода, который отправляем в метод, чтобы он выполнился сразу после получения данных
        weatherService.getWeather(city: "Moscow", callback: {
            // weak для избежания утечки памяти
            [weak self] weather in
            debugPrint(weather)

            self?.loginView.loginLabel.text = weather.city.name
        })
    
        
                
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Отписываемся
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    

    
    
    @objc func loginButtonPressed() {
        let vc = MainTabBarController()
        vc.modalPresentationStyle = .fullScreen
        
        // Получаем входные данные
        guard let userName = loginView.loginInput.text, let userPassword = loginView.passwordInput.text else { return }

        // Авторизация
//        UserSession.instance.login(userName: userName, userPassword: userPassword)
//            self.present(vc, animated: true)

    }
    
    
    // MARK: Keyboard Handler
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

extension LoginViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        // Проверяем URL, на который было совершено перенаправление
        // Если это нужный нам URL (/blank.html), и в нем есть токен, приступим к его обработке, если же нет, дадим зеленый свет на переход между страницами c помощью метода decisionHandler(.allow)
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment else {
            decisionHandler(.allow)
            return
        }
        
        // режем строку с параметрами на части, используя как разделители символы & и =. В результате получаем словарь с параметрами.
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
        
        let token = params["access_token"]
        
        print(token)
        
        
        decisionHandler(.cancel)
    }
}
