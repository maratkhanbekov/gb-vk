import Foundation

class SessionService {
    func getUsedId() -> Int? {
        return SessionManager.instance.user?.usedId
    }
    func getToken() -> String? {
        return SessionManager.instance.user?.accessToken
    }
}
