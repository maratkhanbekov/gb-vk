import UIKit

class LoginFBView: UIView {
    
    private(set) var loginTextField = UITextField()
    private(set) var passwordTextField = UITextField()
    private(set) var loginButton = UIButton(type: .system)
    private(set) var registerButton = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    override func updateConstraints() {
         
        NSLayoutConstraint.activate([
            loginTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            loginTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            loginTextField.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -16),
            loginTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        NSLayoutConstraint.activate([
            passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            passwordTextField.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -16),
            passwordTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        NSLayoutConstraint.activate([
            loginButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            loginButton.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 16),
            registerButton.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
        
        
        
        super.updateConstraints()
    }
    
    
    private func setup() {
        backgroundColor = .white
        setNeedsUpdateConstraints()
        
        setupLoginTextField()
        setupPasswordTextField()
        setupLoginButton()
        setupRegisterButton()
        
        
    }
    
    private func setupLoginTextField() {
        loginTextField.layer.borderColor = UIColor.gray.cgColor
        loginTextField.layer.borderWidth = 1.0
        loginTextField.layer.cornerRadius = 6.0
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(loginTextField)
    }
    
    private func setupPasswordTextField() {
        passwordTextField.layer.borderColor = UIColor.gray.cgColor
        passwordTextField.layer.borderWidth = 1.0
        passwordTextField.layer.cornerRadius = 6.0
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(passwordTextField)
    }
    
    private func setupLoginButton() {
        loginButton.setTitle("Login", for: .normal)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(loginButton)
    }
    
    private func setupRegisterButton() {
        registerButton.setTitle("Register", for: .normal)
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(registerButton)
    }
}
