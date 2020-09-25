import Foundation

class UserSession {
    var user: User?
    var dataBase = DataBase()
    
    static let instance = UserSession()
    private init () {}
    
    func login(userName: String, userPassword: String) {
        user = dataBase.getUser(userName, userPassword)
   }
}
