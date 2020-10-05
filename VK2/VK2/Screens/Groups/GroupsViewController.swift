import UIKit

class GroupsViewController: UIViewController {
    let vkService = VKService()
    let groupsView = GroupsView()
    
    override func loadView() {
        view = groupsView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let userId = SessionManager.instance.user?.usedId, let accessToken = SessionManager.instance.user?.accessToken else {return}
        vkService.getUserGroups(userId: userId, accessToken: accessToken, callback: {
            
            // weak для избежания утечки памяти
            [weak self] userGroups in
            
            print(userGroups)
            
        })
    }
}
