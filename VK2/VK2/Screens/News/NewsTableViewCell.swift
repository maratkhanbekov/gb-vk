import UIKit

class NewsTableViewCell: UITableViewCell {
    
    static var identifier = "NewsTableViewCell"
    let photoService = PhotoService()
    
    var photoWidth: CGFloat = 0
    var photoHeight: CGFloat = 0
    
    let authorPhoto: UIImageView =  {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
        return imageView
    }()
    
    let authorName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        return label
    }()
    
    
    let likesAmount: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        return label
    }()
    
    let commentsAmount: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        return label
    }()
    
    let viewsAmount: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        return label
    }()
    
    let repostsAmount: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        return label
    }()
    
    let postText: UILabel = {
        let textField = UILabel()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.lineBreakMode = .byWordWrapping
        textField.numberOfLines = 3
        textField.backgroundColor = .white
        return textField
    }()
    
    let postPhoto: UIImageView =  {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
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
            authorPhoto.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            authorPhoto.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            authorPhoto.heightAnchor.constraint(equalToConstant: 30),
            authorPhoto.widthAnchor.constraint(equalToConstant: 30)
        ])

        NSLayoutConstraint.activate([
            authorName.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            authorName.leadingAnchor.constraint(equalTo: authorPhoto.leadingAnchor, constant: 50),
        ])
        
        NSLayoutConstraint.activate([
            postPhoto.topAnchor.constraint(equalTo: authorPhoto.bottomAnchor, constant: 15),
            postPhoto.leadingAnchor.constraint(equalTo: leadingAnchor),
            postPhoto.widthAnchor.constraint(equalToConstant: photoWidth),
            postPhoto.heightAnchor.constraint(equalToConstant: photoHeight)

        ])
        
        NSLayoutConstraint.activate([
            postText.topAnchor.constraint(equalTo: postPhoto.bottomAnchor, constant: 10),
            postText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            postText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        ])

        NSLayoutConstraint.activate([
            likesAmount.topAnchor.constraint(equalTo: postText.bottomAnchor, constant: 15),
            likesAmount.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15)
        ])

        NSLayoutConstraint.activate([
            commentsAmount.topAnchor.constraint(equalTo: postText.bottomAnchor, constant: 15),
            commentsAmount.leadingAnchor.constraint(equalTo: likesAmount.trailingAnchor, constant: 15)
        ])

        NSLayoutConstraint.activate([
            viewsAmount.topAnchor.constraint(equalTo: postText.bottomAnchor, constant: 15),
            viewsAmount.leadingAnchor.constraint(equalTo: commentsAmount.trailingAnchor, constant: 15)
        ])

        NSLayoutConstraint.activate([
            repostsAmount.topAnchor.constraint(equalTo: postText.bottomAnchor, constant: 15),
            repostsAmount.leadingAnchor.constraint(equalTo: viewsAmount.trailingAnchor, constant: 15),
            repostsAmount.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])

        super.updateConstraints()
    }
    
    
    func setup() {
        contentView.addSubview(authorPhoto)
        contentView.addSubview(authorName)
        contentView.addSubview(postPhoto)
        
        // Вместо addSubview(postText)
        contentView.addSubview(postText)
        contentView.addSubview(likesAmount)
        contentView.addSubview(commentsAmount)
        contentView.addSubview(viewsAmount)
        contentView.addSubview(repostsAmount)
        
        setNeedsUpdateConstraints()
    }
    
    func config(newsPost: NewsPost) {
        
        authorName.text = newsPost.authorName
        
        photoService.photo(url: newsPost.authorPhoto) { [unowned self] image in
            DispatchQueue.main.async {
                self.authorPhoto.image = image
                
            }
        }
        
        photoService.photo(url: newsPost.postPhoto) { [unowned self] image in
            DispatchQueue.main.async {
                self.postPhoto.image = image
            }
        }
        
        likesAmount.text = "\(newsPost.likesAmount) ❤️"
        commentsAmount.text = "\(newsPost.commentsAmount) 📝"
        viewsAmount.text = "\(newsPost.viewsAmount) 👀"
        repostsAmount.text = "\(newsPost.repostsAmount) ➕"
        postText.text = (newsPost.postText)
 
        
        photoWidth = contentView.bounds.width
        
        photoHeight = CGFloat(photoWidth) * newsPost.aspectRatio
        
        setNeedsUpdateConstraints()
        
    }
}
