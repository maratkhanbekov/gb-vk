import UIKit
import WebKit

class LoginVKViewController: UIViewController {
    
    let webView = LoginVKView()
    let vkService = VKService()
    
    override func loadView() {

        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7615879"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.68"),
            URLQueryItem(name: "scope", value: "wall, friends, photos"),
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        
        webView.load(request)
    }
}
