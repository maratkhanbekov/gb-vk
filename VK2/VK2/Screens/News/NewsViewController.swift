import UIKit


class NewsViewController: UIViewController {
    let newsView = NewsView()
    var newsPosts: NewsPosts?
    
    let vkService = VKService()
    let sessionService = SessionService()
    
    let operationQueue = OperationQueue()
    
    override func loadView() {
        super.loadView()
        view = newsView
    }
    
    override func viewDidLoad() {
        newsView.tableView.delegate = self
        newsView.tableView.dataSource = self
        newsView.tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        
        // Загружаем данные
//        guard let userId = sessionService.getUsedId(), let accessToken = sessionService.getToken() else { return }
        
        vkService.getNewsPost(callback: { [weak self] newsPostfeed in
     
            
            let parsingNewsPostOperation = ParsingNewsPostOperation(inputNewsPostFeed: newsPostfeed)
            parsingNewsPostOperation.completionBlock =  {

                if let newsPosts = parsingNewsPostOperation.outputNewsPosts {
                self?.newsPosts = newsPosts
                    OperationQueue.main.addOperation {
                    self?.newsView.tableView.reloadData()
                    }
                }
            }
            self?.operationQueue.addOperation(parsingNewsPostOperation)
        })
        
        
    }
}

extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        newsPosts?.posts.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 600
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as! NewsTableViewCell
        
        guard let newsPost = newsPosts?.posts[indexPath.row] else { return cell }
        
        cell.config(newsPost: newsPost)
        
        guard let postPhotoImage = cell.postPhoto.image else { return cell }
    
        return cell
    }
    
    
    
    
}

extension NewsViewController: UITableViewDelegate {}
