import UIKit

class NewsTableViewCell: UITableViewCell {
    
    static var identifier = "NewsTableViewCell"
    
    let authorPhoto: UIImageView =  {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let authorName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    let likesAmount: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let commentsAmount: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let viewsAmount: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let repostsAmount: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let postText: UILabel = {
        let textField = UILabel()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.lineBreakMode = .byWordWrapping
        textField.numberOfLines = 3
        return textField
    }()
    
    let postPhoto: UIImageView =  {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {

        NSLayoutConstraint.activate([
            authorPhoto.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            authorPhoto.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            authorPhoto.heightAnchor.constraint(equalToConstant: 30),
            authorPhoto.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            authorName.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            authorName.leadingAnchor.constraint(equalTo: authorPhoto.leadingAnchor, constant: 50),
        ])
        
        NSLayoutConstraint.activate([
            postPhoto.centerXAnchor.constraint(equalTo: centerXAnchor),
            postPhoto.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -50),
            postPhoto.widthAnchor.constraint(equalToConstant: frame.width),
            postPhoto.heightAnchor.constraint(equalToConstant: frame.width),
            
        ])
        
        NSLayoutConstraint.activate([
            postText.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -60),
            postText.centerXAnchor.constraint(equalTo: centerXAnchor),
            postText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            postText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        ])
        
        NSLayoutConstraint.activate([
            likesAmount.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            likesAmount.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            commentsAmount.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            commentsAmount.leadingAnchor.constraint(equalTo: likesAmount.trailingAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            viewsAmount.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            viewsAmount.leadingAnchor.constraint(equalTo: commentsAmount.trailingAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            repostsAmount.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            repostsAmount.leadingAnchor.constraint(equalTo: viewsAmount.trailingAnchor, constant: 15)
        ])
        
        super.updateConstraints()
    }
    
    
    func setup() {
        addSubview(authorPhoto)
        addSubview(authorName)
        addSubview(postPhoto)
        addSubview(postText)
        addSubview(likesAmount)
        addSubview(commentsAmount)
        addSubview(viewsAmount)
        addSubview(repostsAmount)
        
        setNeedsUpdateConstraints()
    }
    
    func config(newsPost: NewsPost) {
        
        authorName.text = newsPost.authorName
        
        if let authorPhotoURL = URL(string: newsPost.authorPhoto) {
            authorPhoto.load(url: authorPhotoURL)
        }

        if let postPhotoURL = URL(string: newsPost.postPhoto) {
            postPhoto.load(url: postPhotoURL)
        }
        likesAmount.text = "\(newsPost.likesAmount) ❤️"
        commentsAmount.text = "\(newsPost.commentsAmount) 📝"
        viewsAmount.text = "\(newsPost.viewsAmount) 👀"
        repostsAmount.text = "\(newsPost.repostsAmount) ➕"
        postText.text = (newsPost.postText)
    }
}
