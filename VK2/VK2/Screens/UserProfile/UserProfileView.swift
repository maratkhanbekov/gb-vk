import UIKit

class UserProfileView: UIView {
    
    let stackView = UIStackView()
    
    var getFriendsButton = UIButton()
    var getPhotosButton = UIButton()
    var getGroupsButton = UIButton()
    
    let searchGroupInput = TextField()
    var searchGroupButton = UIButton()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
            
            
        ])
    }
    
    func getStandardButton(_ title: String) -> UIButton {
        let button = UIButton()
        
        button.setTitle(title, for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }
    
    func setup() {
        backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        
        getFriendsButton = getStandardButton("Получить список друзей")
        getPhotosButton = getStandardButton("Получить список фотографий")
        getGroupsButton = getStandardButton("Получить список групп")
        searchGroupButton = getStandardButton("Найти группу по запросу")
        
        searchGroupInput.placeholder = "Поиск группы"
        searchGroupInput.layer.cornerRadius = 20
        searchGroupInput.backgroundColor = .white
        searchGroupInput.textColor = .black

        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(searchGroupInput)
        stackView.addArrangedSubview(searchGroupButton)
        
        stackView.setCustomSpacing(50, after: searchGroupButton)
        
        stackView.addArrangedSubview(getFriendsButton)
        stackView.addArrangedSubview(getPhotosButton)
        stackView.addArrangedSubview(getGroupsButton)
        
     
        
        
        addSubview(stackView)
        
        setNeedsUpdateConstraints()
    }
    
    
}

class TextField: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
