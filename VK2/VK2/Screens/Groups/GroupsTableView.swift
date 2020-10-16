import UIKit

class GroupsTableView: UIView {
    
    let tableView = UITableView()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])

        super.updateConstraints()
    }
    
    func setup() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tableView)
        setNeedsUpdateConstraints()
    }
}
