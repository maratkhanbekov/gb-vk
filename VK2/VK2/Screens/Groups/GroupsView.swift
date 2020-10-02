import UIKit


class GroupsView: UIView {
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
    }
    
    func setup() {
        backgroundColor = .green
    }
}
