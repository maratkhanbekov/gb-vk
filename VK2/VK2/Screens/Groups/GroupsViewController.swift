import UIKit
import RealmSwift

class GroupsViewController: UIViewController {
    
    // MARK: Services
    let sessionService = SessionService()
    let vkService = VKService()
    let dataService = FirebaseService()
    
    let groupsTableView = GroupsTableView()
    var userGroups: [UserGroup]?
    
    override func loadView() {
        super.loadView()
        view = groupsTableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Достаем ключи для авторизации
        guard let userId = sessionService.getUsedId(), let accessToken = sessionService.getToken() else { return }
        

        dataService.getUserGroups(userId: userId, accessToken: accessToken)
            .done { userGroups in
                self.userGroups = userGroups
                self.groupsTableView.tableView.reloadData()
            }
        
        // Добавляем TableView
        view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
        // Настраиваем TableView
        groupsTableView.tableView.delegate = self
        groupsTableView.tableView.dataSource = self
        groupsTableView.tableView.register(GroupsTableViewCell.self, forCellReuseIdentifier: GroupsTableViewCell.identifier)
        
    }
}
