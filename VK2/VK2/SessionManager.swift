import Foundation


class SessionManager {
    var user: User?
    
    static let instance = SessionManager()
    private init () {}

    func createUser(userId: Int, accessToken: String) {
        user = User(usedId: userId, accessToken: accessToken)
    }
}
