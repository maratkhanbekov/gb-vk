import UIKit

class GroupsViewController: UIViewController {
    
    // MARK: Services
    let sessionService = SessionService()
    let vkService = VKService()
    let dataService = RealmSaveService()
    
    let groupsTableView = UITableView()
    var userGroups: [UserGroup]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Достаем ключи для авторизации
        guard let userId = sessionService.getUsedId(), let accessToken = sessionService.getToken() else { return }
        
        if let userGroups = dataService.getUserGroups() {
            
            
            self.userGroups = userGroups
            self.groupsTableView.reloadData()
        }
        
        else {
            
            vkService.getUserGroups(userId: userId, accessToken: accessToken, callback: { [weak self] userGroups in
                
                self?.dataService.saveUserGroups(userGroups)
                self?.userGroups = userGroups
                self?.groupsTableView.reloadData()
                
            })
        }
        
        // Добавляем TableView
        view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        view.addSubview(groupsTableView)
        
        // Настраиваем TableView
        groupsTableView.delegate = self
        groupsTableView.dataSource = self
        groupsTableView.register(GroupsTableViewCell.self, forCellReuseIdentifier: GroupsTableViewCell.identifier)
        
        // MARK: TableView Constraints
        groupsTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            groupsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            groupsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            groupsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            groupsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
