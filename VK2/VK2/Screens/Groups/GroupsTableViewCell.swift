import UIKit

class GroupsTableViewCell: UITableViewCell {
    static var identifier = "GroupsTableViewCell"
    let photoService = PhotoService()
    let bgColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    
    let groupImageView: AsyncImageView = {
        let img = AsyncImageView()
        img.image = UIImage(named: "spongeBob")
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 50
        img.clipsToBounds = true
        return img
    }()
    
    let groupName: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        return label
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        NSLayoutConstraint.activate([
            groupImageView.widthAnchor.constraint(equalToConstant: 100),
            groupImageView.heightAnchor.constraint(equalToConstant: 100),
            groupImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            groupImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            
            groupName.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            groupName.leadingAnchor.constraint(equalTo: groupImageView.leadingAnchor, constant: 120)
        ])
        
        
    }
    
    func setup() {
        
        backgroundColor = bgColor
        
        self.contentView.addSubview(groupImageView)
        self.contentView.addSubview(groupName)
        setNeedsUpdateConstraints()
    }
    
    func config(userGroupName: String, url: String) {
        groupName.text = userGroupName
        
        groupName.backgroundColor = bgColor
        groupImageView.backgroundColor = bgColor
        
        photoService.photo(url: url) { [unowned self] image in
            self.groupImageView.image = image
        }
    }
}
