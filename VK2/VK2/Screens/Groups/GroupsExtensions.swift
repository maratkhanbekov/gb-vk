import UIKit
import RealmSwift
import Realm

extension GroupsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userGroups?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GroupsTableViewCell.identifier, for: indexPath) as! GroupsTableViewCell
        
        guard let userGroup = userGroups?[indexPath.row] else { return cell }
        cell.config(userGroupName: userGroup.name, url: userGroup.photo100)
        
        return cell
    }
}


extension GroupsViewController: UITableViewDelegate {
}



extension GroupsViewController: RealmOutput {
    
    // Функция для обработки realm notifications
    func update(_ changes: RealmCollectionChange<Results<UserGroupsObject>>) {
        switch changes {
        case .initial(let results):
            groupsTableView.tableView.reloadData()
        case let .update(results, deletions, insertions, modifications):
            // Если приходит обновление, берем из него обновленный объект и загружаем в массив с данными
            userGroups = results.first!.groups.map{ UserGroup(name: $0.name, photo_100: $0.photo_100)}
            groupsTableView.tableView.reloadData()
        case let .error(error):
            debugPrint(error.localizedDescription)
        }
    }
}
