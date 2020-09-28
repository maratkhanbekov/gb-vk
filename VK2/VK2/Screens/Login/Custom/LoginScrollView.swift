import UIKit

class LoginView: UIScrollView {
    
    let loginLabel = UILabel()
    let passwordLabel = UILabel()
    
    let loginInput = UITextField()
    let passwordInput = UITextField()
    
    let loginButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setup() {
        backgroundColor = .white
        
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        loginLabel.text = "Логин"
        loginLabel.textAlignment = .center
        loginLabel.textColor = .black
        addSubview(loginLabel)
        
        loginInput.translatesAutoresizingMaskIntoConstraints = false
        loginInput.layer.borderColor = UIColor.gray.cgColor
        loginInput.layer.borderWidth = 1
        loginInput.layer.cornerRadius = 10
        loginInput.text = "SpongeBob"
        addSubview(loginInput)
        
        
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.text = "Пароль"
        passwordLabel.textAlignment = .center
        passwordLabel.textColor = .black
        addSubview(passwordLabel)
        
        passwordInput.translatesAutoresizingMaskIntoConstraints = false
        passwordInput.layer.borderColor = UIColor.gray.cgColor
        passwordInput.layer.borderWidth = 1
        passwordInput.layer.cornerRadius = 10
        passwordInput.text = "123"
        passwordInput.isSecureTextEntry = true
        addSubview(passwordInput)

        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.backgroundColor = .blue
        loginButton.layer.cornerRadius = 10
        loginButton.tintColor = .white
        loginButton.setTitle("Войти", for: .normal)
        addSubview(loginButton)
        
        setNeedsUpdateConstraints()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        let inputFieldHeight: CGFloat = 40
        let inputFieldWidth: CGFloat = 130
        
        NSLayoutConstraint.activate([
            loginLabel.topAnchor.constraint(equalTo: topAnchor, constant: 200),
            loginLabel.heightAnchor.constraint(equalToConstant: 20),
            loginLabel.widthAnchor.constraint(equalToConstant: 80),
            loginLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            loginInput.topAnchor.constraint(equalTo: loginLabel.topAnchor, constant: 30),
            loginInput.heightAnchor.constraint(equalToConstant: inputFieldHeight),
            loginInput.widthAnchor.constraint(equalToConstant: inputFieldWidth),
            loginInput.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            passwordLabel.topAnchor.constraint(equalTo: loginInput.topAnchor, constant: 40),
            passwordLabel.heightAnchor.constraint(equalToConstant: 20),
            passwordLabel.widthAnchor.constraint(equalToConstant: 80),
            passwordLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            passwordInput.topAnchor.constraint(equalTo: passwordLabel.topAnchor, constant: 30),
            passwordInput.heightAnchor.constraint(equalToConstant: inputFieldHeight),
            passwordInput.widthAnchor.constraint(equalToConstant: inputFieldWidth),
            passwordInput.centerXAnchor.constraint(equalTo: centerXAnchor),

            loginButton.topAnchor.constraint(equalTo: passwordInput.topAnchor, constant: 70),
            loginButton.heightAnchor.constraint(equalToConstant: inputFieldHeight),
            loginButton.widthAnchor.constraint(equalToConstant: inputFieldWidth),
            loginButton.centerXAnchor.constraint(equalTo: centerXAnchor)
            
        ])
    }
    
   
}
