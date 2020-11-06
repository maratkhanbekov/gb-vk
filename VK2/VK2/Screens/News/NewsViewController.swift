import UIKit


class NewsViewController: UIViewController {
    let newsView = NewsView()
    
    override func loadView() {
        super.loadView()
        view = newsView
    }
    
    override func viewDidLoad() {
        newsView.tableView.delegate = self
        newsView.tableView.dataSource = self
        newsView.tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
    }
}
