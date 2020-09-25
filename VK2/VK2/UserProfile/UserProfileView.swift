import UIKit

class UserProfileView: UIView {
    
    let userNameLabel = UILabel()
    let userTokenLabel = UILabel()
    
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
            userNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -30),
            userNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            userTokenLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 30),
            userTokenLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    
    func setup() {
        backgroundColor = .orange
        userNameLabel.textColor = .black
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(userNameLabel)
        
        userTokenLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(userTokenLabel)
        
        setNeedsUpdateConstraints()
    }
}
