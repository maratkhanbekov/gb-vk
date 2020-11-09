import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    static var identifier = "PhotoCollectionViewCell"
   
    let groupImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleToFill
        return imgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        NSLayoutConstraint.activate([
            groupImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            groupImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            groupImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            groupImageView.topAnchor.constraint(equalTo: topAnchor),
            groupImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            groupImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func setup() {
        addSubview(groupImageView)
        setNeedsUpdateConstraints()
    }
    
}
