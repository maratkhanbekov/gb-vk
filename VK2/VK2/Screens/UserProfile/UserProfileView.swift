import UIKit

class UserProfileView: UIView {
    
    var userPic = UIImageView()
    var nameLabel = UILabel()
    var friendsLabel = UILabel()
    var friendsCount = 0
    
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
            
            userPic.widthAnchor.constraint(equalToConstant: 100),
            userPic.heightAnchor.constraint(equalToConstant: 100),
            userPic.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            userPic.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            
            nameLabel.leadingAnchor.constraint(equalTo: userPic.leadingAnchor, constant: 130),
            nameLabel.topAnchor.constraint(equalTo: userPic.topAnchor, constant: 40),
            
            friendsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            friendsLabel.topAnchor.constraint(equalTo: userPic.topAnchor, constant: 180),
        
        ])
    }
    
    func setup() {
        backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
        userPic.image = UIImage(named: "spongeBob")
        userPic.layer.cornerRadius = 50
        userPic.clipsToBounds = true
        userPic.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.text = "Sponge Bob"
        nameLabel.textColor = .white
        nameLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        nameLabel.sizeToFit()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        friendsLabel.text = "\(friendsCount) друзей"
        friendsLabel.textColor = .white
        friendsLabel.font.withSize(12)
        friendsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(userPic)
        addSubview(nameLabel)
        addSubview(friendsLabel)
        setNeedsUpdateConstraints()
        
    }
}
