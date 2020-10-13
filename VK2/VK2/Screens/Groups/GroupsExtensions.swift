import UIKit


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
        cell.groupName.text = userGroup.name
        
        guard let photoUrl = URL(string: userGroup.photo_100) else { return cell }
        cell.groupImageView.load(url: photoUrl)
        
        return cell
    }
}


extension GroupsViewController: UITableViewDelegate {
}
