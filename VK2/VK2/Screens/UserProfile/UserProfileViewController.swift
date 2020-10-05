import UIKit

class UserProfileViewController: UIViewController {
    let userProfileView = UserProfileView()
    let vkService = VKService()
    var userProfile: UserProfile?
    
    override func loadView() {
        view = userProfileView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let userId = SessionManager.instance.user?.usedId, let accessToken = SessionManager.instance.user?.accessToken else {return}
        vkService.getUserInfo(userId: userId, accessToken: accessToken, callback: {
            // weak для избежания утечки памяти
            [weak self] userProfile in

            // Инициализируем данные
            self?.userProfile = userProfile
            
            // Обновляем поля через главный поток
            DispatchQueue.main.async {
                self?.userProfileView.nameLabel.text = self?.userProfile?.first_name
                
                if let photoURL = URL(string:(self?.userProfile!.photo_100)!) {
                self?.userProfileView.userPic.load(url: photoURL)
                }
                
                if let followersCount = self?.userProfile?.followers_count {
                    self?.userProfileView.friendsLabel.text = "\(followersCount) подписчиков"
                }
                else {
                    self?.userProfileView.friendsLabel.text = "Подписчиков нет"
                }
            }
            
            
        })
    }

}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
