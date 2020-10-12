import UIKit

class UserProfileViewController: UIViewController {
    
    let userProfileView = UserProfileView()
    let vkService = VKService()
    let sessionService = SessionService()
    var userProfile: UserProfile?
    
    override func loadView() {
        view = userProfileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Достаем ключи для авторизации из сессии
        guard let userId = sessionService.getUsedId(), let accessToken = sessionService.getToken() else { return }
        
        // Запрашиваем данные из БД
        if let userProfile = vkService.getUserData() {
            self.userProfile = userProfile
            updateUserProfile()
        }
        
        // Если данных нет, запрашиваем данные из VK
        else {
            vkService.getUserInfo(userId: userId, accessToken: accessToken, callback: {
                // weak для избежания утечки памяти
                [weak self] userProfile in
                self?.userProfile = userProfile
                self?.updateUserProfile()
            })
        }
    }
    
    // Функция для обновления интерфейса
    func updateUserProfile() {
        DispatchQueue.main.async {
            self.userProfileView.nameLabel.text = self.userProfile?.first_name
            
            if let photoURL = URL(string:(self.userProfile!.photo_100)) {
                self.userProfileView.userPic.load(url: photoURL)
            }
            
            if let followersCount = self.userProfile?.followers_count {
                self.userProfileView.friendsLabel.text = "\(followersCount) подписчиков"
            }
            else {
                self.userProfileView.friendsLabel.text = "Подписчиков нет"
            }
        }
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
