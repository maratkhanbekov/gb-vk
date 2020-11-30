import UIKit
import PromiseKit

class NewsViewController: UIViewController {
    let newsView = NewsView()
    var newsPosts: NewsPosts?
    var nextFrom: String?
    var isLoading = false
    
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
        
        loadNews() {
            self.newsView.tableView.reloadData()
        }
        newsView.refreshControl.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
        
        newsView.tableView.prefetchDataSource = self
    }
    
    func loadNews(callback: (() -> Void)? = nil) {
        firstly {
            vkService.getNewsPost()
        }
        .done { newsPostFeed in
            // Создаем операцию парсинга
            let parsingNewsPostOperation = ParsingNewsPostOperation(inputNewsPostFeed: newsPostFeed)
            
            // Указываем, что сделать после ее завершения
            parsingNewsPostOperation.completionBlock =  {
                
                // Если удалось распарсить ленту
                if let newsPosts = parsingNewsPostOperation.outputNewsPosts {
                    self.newsPosts = newsPosts
                    self.nextFrom = newsPosts.nextFrom
                    // В главной очереди обновляем интерфейс и запускаем callback для refresh control
                    OperationQueue.main.addOperation {
                        self.newsView.tableView.reloadData()
                        callback?()
                    }
                }
            }
            
            // Добавляем созданную операцию
            self.operationQueue.addOperation(parsingNewsPostOperation)
        }
    }
    
    @objc
    func refreshNews() {
        loadNews() {
            self.newsView.refreshControl.endRefreshing()
        }
    }
    
    
}

extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        newsPosts?.posts.count ?? 0
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 600
//    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as! NewsTableViewCell
        guard let newsPost = newsPosts?.posts[indexPath.row] else { return cell }
        cell.config(newsPost: newsPost)
        return cell
    }
}

extension NewsViewController: UITableViewDelegate {}

extension NewsViewController: UITableViewDataSourcePrefetching {

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {

        // Получаем количество текущих ячеек
        guard let postCount = newsPosts?.posts.count else { return }

        // Выбираем максимальный номер секции, которую нужно будет отобразить в ближайшее время
        guard let maxSection = indexPaths.map({ $0.row }).max() else { return }

        // Проверяем, является ли эта секция одной из трех ближайших к концу
        if maxSection > postCount - 3,

           // Убеждаемся, что мы уже не в процессе загрузки данных
           !isLoading {

            // Начинаем загрузку данных и меняем флаг isLoading
            isLoading = true


            firstly {
                // Запрашиваем данные с параметром nextFrom для выбора только следующих постов
                vkService.getNewsPost(startFrom: nextFrom)
            }
            .done { newsPostFeed in
                // Создаем операцию парсинга
                let parsingNewsPostOperation = ParsingNewsPostOperation(inputNewsPostFeed: newsPostFeed)

                // Указываем, что сделать после ее завершения
                parsingNewsPostOperation.completionBlock =  {

                    // Если удалось распарсить ленту
                    if let newPosts = parsingNewsPostOperation.outputNewsPosts {

                        // Создаем новую партию indexPath для текущей tableView
                        let indexPaths = Array(postCount ..< postCount + newPosts.posts.count).map { IndexPath(row: $0, section: 0)}
                        self.newsPosts?.posts.append(contentsOf: newPosts.posts)

                        // Записываем параметр на будущие загрузки
                        self.nextFrom = newPosts.nextFrom
                        // В главной очереди обновляем интерфейс и запускаем callback для refresh control
                        OperationQueue.main.addOperation {
                            self.newsView.tableView.insertRows(at: indexPaths, with: .automatic)
                            self.isLoading = false
                        }
                    }
                }
                // Добавляем созданную операцию
                self.operationQueue.addOperation(parsingNewsPostOperation)
            }
        }
    }
}

