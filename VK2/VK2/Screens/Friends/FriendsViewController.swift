import UIKit

class FriendsViewController: UIViewController {
    
    let friendsView = FriendsView()
    
    override func loadView() {
        view = friendsView
    }
}
