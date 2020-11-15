import UIKit
import RealmSwift

class UserProfileViewController: UIViewController {
    
    let userProfileView = UserProfileView()
    
    // Services
    let vkService = VKService()
    let sessionService = SessionService()
    let dataService = FirebaseService()
    let photoService = PhotoService()
    
    // Data
    var userProfile: UserProfile?
    var token: NotificationToken?
    
    override func loadView() {
        view = userProfileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Достаем ключи для авторизации
        guard let userId = sessionService.getUsedId(), let accessToken = sessionService.getToken() else { return }
        

        dataService.getUserData() { [unowned self] userProfile in
            self.userProfile = userProfile
            
            updateUserProfile()
            
        }
    }
    
    // Функция для обновления интерфейса
    func updateUserProfile() {
        DispatchQueue.main.async {
            self.userProfileView.nameLabel.text = self.userProfile?.first_name
            
            if let url = self.userProfile?.photo_100 {
                self.photoService.photo(url: url) { [unowned self] image in
                    self.userProfileView.userPic.image = image
                }
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
