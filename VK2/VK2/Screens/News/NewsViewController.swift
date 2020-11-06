import UIKit


class NewsViewController: UIViewController {
    let newsView = NewsView()
    var newsPosts: NewsPosts?
    
    let vkService = VKService()
    let sessionService = SessionService()
    
    override func loadView() {
        super.loadView()
        view = newsView
    }
    
    override func viewDidLoad() {
        newsView.tableView.delegate = self
        newsView.tableView.dataSource = self
        newsView.tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        
        // Загружаем данные
        guard let userId = sessionService.getUsedId(), let accessToken = sessionService.getToken() else { return }

        // Создаем очередь
        let vkQueue = DispatchQueue(label: "vkQueue",
                              qos: DispatchQoS.utility,
                              autoreleaseFrequency: DispatchQueue.AutoreleaseFrequency.inherit,
                              target: DispatchQueue.global(qos: DispatchQoS.QoSClass.utility))
        
        
        vkQueue.sync {
            vkService.getNewsPost(userId: userId, accessToken: accessToken, callback: { [weak self] newsPostfeed in
                
                // Парсим данные
                self?.newsPosts = self?.vkService.parseNewsPost(newsPostFeed: newsPostfeed)
                
                // Обновляем интерфейс
                DispatchQueue.main.async {
                    self?.newsView.tableView.reloadData()
                }
            })
        }
        
    }
}

extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        newsPosts?.posts.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.width + 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as! NewsTableViewCell
        guard let newsPost = newsPosts?.posts[indexPath.row] else { return cell }
        cell.config(newsPost: newsPost)
        return cell
    }
}

extension NewsViewController: UITableViewDelegate {}
