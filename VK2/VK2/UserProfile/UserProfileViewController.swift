import UIKit

class UserProfileViewController: UIViewController {
    var userProfileView = UserProfileView()

    override func loadView() {
        view = userProfileView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        userProfileView.userNameLabel.text = UserSession.instance.user?.name
        userProfileView.userTokenLabel.text = UserSession.instance.user?.token
    }
}
