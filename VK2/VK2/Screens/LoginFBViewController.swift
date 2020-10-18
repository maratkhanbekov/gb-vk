import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class LoginFBViewController: UIViewController {
    var ref: DatabaseReference!
    
    let rootView = LoginFBView()
    
    override func loadView() {
        view = rootView
    }
    
    init() {
        super.init(nibName: .none, bundle: .none)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        let username = "donkey"
        let userUid = "123"
        self.ref.child("users").child(userUid).setValue(["username": username])
        
        rootView.registerButton.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
        rootView.loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
    }
    
    private func setup() {
    }
    
    
    @objc
    func registerTapped() {
        let email = rootView.loginTextField.text!
        let pwd = rootView.passwordTextField.text!
        
        
        // Создаем пользователя
        Auth.auth().createUser(withEmail: email, password: pwd) { [unowned self] (result, error) in
            switch error {
            case let .some(error):
                debugPrint(error.localizedDescription)
            default:
                // Если без ошибок создали, то заходим через учетную запись
                signIn(withEmail: email, password: pwd) {
                    let mainViewController = MainTapBarController()
                    navigationController?.pushViewController(mainViewController, animated: true)
                }
            }
        }
        debugPrint(email, pwd)
    }
    
    @objc
    func loginTapped() {
        let email = rootView.loginTextField.text!
        let pwd = rootView.passwordTextField.text!
        
        signIn(withEmail: email, password: pwd) { [unowned self] in
            let mainViewController = MainTapBarController()
            navigationController?.pushViewController(mainViewController, animated: true)
            
        }
    }
    
    private func signIn(withEmail email: String, password: String, success: @escaping() -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            switch error {
            case let .some(error):
                debugPrint(error.localizedDescription)
            default:
                success()
            }
        }
    }
}
