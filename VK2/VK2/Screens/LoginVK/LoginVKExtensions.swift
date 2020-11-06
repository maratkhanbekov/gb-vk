import WebKit


extension LoginVKViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map{$0.components(separatedBy: "=")}.reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        
        // Авторизуем пользователя с данными
        guard let user_id = params["user_id"], let userId = Int(user_id) else { return }
        guard let accessToken = params["access_token"] else { return }
        
        SessionManager.instance.SignIn(userId: userId, accessToken: accessToken)
        
        // Запускаем экран с NavigationVC
        let mainNavigationViewController = MainTapBarController()
        mainNavigationViewController.modalPresentationStyle = .fullScreen
        self.present(mainNavigationViewController, animated: true, completion: nil)
        
        decisionHandler(.cancel)
    }
}
