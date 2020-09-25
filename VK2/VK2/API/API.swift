import Foundation

struct DataBase {
    var users = [
        User(id: 0, name: "TechUser", password: "123", token: "secret-token-123"),
        User(id: 1, name: "SpongeBob", password: "123", token: "secret-token-123"),
        User(id: 2, name: "Patrick", password: "123", token: "secret-token-123"),
    ]
    
    func getUser(_ userName: String, _ userPassword: String) -> User? {
        guard let user = users.first(where: {($0.name == userName) && ($0.password == userPassword)}) else { return users[0] }
        
        return user
    }
}
