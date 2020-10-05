import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    static var identifier = "PhotoCollectionViewCell"
    weak var textLabel: UILabel!
    
    override init(frame: CGRect) {
           super.init(frame: frame)

           let textLabel = UILabel(frame: .zero)
           textLabel.translatesAutoresizingMaskIntoConstraints = false
           self.contentView.addSubview(textLabel)
           NSLayoutConstraint.activate([
               self.contentView.centerXAnchor.constraint(equalTo: textLabel.centerXAnchor),
               self.contentView.centerYAnchor.constraint(equalTo: textLabel.centerYAnchor),
           ])
           self.textLabel = textLabel
           self.reset()
       }

       required init?(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }

       override func prepareForReuse() {
           super.prepareForReuse()
           self.reset()
       }

       func reset() {
           self.textLabel.textAlignment = .center
       }
    
}
