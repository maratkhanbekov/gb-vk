import Foundation


class SessionManager {
    var user: User?
    
    static let instance = SessionManager()
    private init () {}

    func SignIn(userId: Int, accessToken: String) {
        user = User(usedId: userId, accessToken: accessToken)
    }
}
