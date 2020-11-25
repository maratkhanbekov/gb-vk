import UIKit

class NewsView: UIView {
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 1.0
        tableView.backgroundColor = .white
        return tableView
    }()
    
    // Инициализируем и присваиваем сущность UIRefreshControl
    let refreshControl = UIRefreshControl()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        super.updateConstraints()
    }
    
    
    func setup() {
        backgroundColor = .red
        addSubview(tableView)
        setupRefreshControl()
        setNeedsUpdateConstraints()
    }
    
    private func setupRefreshControl() {
        // Цвет спиннера
        refreshControl.tintColor = .red
        // отображаемый им текст
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing...")
        tableView.refreshControl = refreshControl
    }
    
}
