import UIKit

class UserProfileViewController: UIViewController {
    var userProfileView = UserProfileView()
    let vkService = VKService()

    override func loadView() {
        view = userProfileView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        userProfileView.getFriendsButton.addTarget(self, action: #selector(getFriends), for: .touchUpInside)
        userProfileView.getPhotosButton.addTarget(self, action: #selector(getPhotos), for: .touchUpInside)
        userProfileView.getGroupsButton.addTarget(self, action: #selector(getGroups), for: .touchUpInside)
        userProfileView.searchGroupButton.addTarget(self, action: #selector(searchGroups), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    @objc func getFriends() {
        vkService.getFriends(userId: SessionManager.instance.user!.usedId, accessToken: SessionManager.instance.user!.accessToken)
    }
    
    @objc func getPhotos() {
        vkService.getPhotos(userId: SessionManager.instance.user!.usedId, accessToken: SessionManager.instance.user!.accessToken)
    }
    
    @objc func getGroups() {
        vkService.getGroups(userId: SessionManager.instance.user!.usedId, accessToken: SessionManager.instance.user!.accessToken)
    }
    
    @objc func searchGroups() {
        guard let request = userProfileView.searchGroupInput.text, request != "" else {
            debugPrint("Введите ключевые словая для поиска")
            return }
        vkService.searchGroups(q: request, accessToken: SessionManager.instance.user!.accessToken)
    }
}
