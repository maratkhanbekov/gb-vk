import UIKit
import RealmSwift

class GroupsViewController: UIViewController {
    
    // MARK: Services
    let sessionService = SessionService()
    let vkService = VKService()
    let dataService = RealmSaveService()
    
    let groupsTableView = GroupsTableView()
    var userGroups: [UserGroup]?
    
    override func loadView() {
        super.loadView()
        view = groupsTableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Назначаем делегатом для возможности
        dataService.delegate = self
        
        // Достаем ключи для авторизации
        guard let userId = sessionService.getUsedId(), let accessToken = sessionService.getToken() else { return }
        
        if let userGroups = dataService.getUserGroups() {
            
            
            self.userGroups = userGroups
            self.groupsTableView.tableView.reloadData()
        }
        
        else {
            
            vkService.getUserGroups(userId: userId, accessToken: accessToken, callback: { [weak self] userGroups in
                
                self?.dataService.saveUserGroups(userGroups)
                self?.userGroups = userGroups
                self?.groupsTableView.tableView.reloadData()
                
            })
        }
        
        // Добавляем TableView
        view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
        // Настраиваем TableView
        groupsTableView.tableView.delegate = self
        groupsTableView.tableView.dataSource = self
        groupsTableView.tableView.register(GroupsTableViewCell.self, forCellReuseIdentifier: GroupsTableViewCell.identifier)
        
    }
}
