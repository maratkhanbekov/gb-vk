import UIKit
import WebKit


class LoginVKView: WKWebView {
    override init(frame: CGRect, configuration: WKWebViewConfiguration) {
        let configuration = WKWebViewConfiguration()
        super.init(frame: .zero, configuration: configuration)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

