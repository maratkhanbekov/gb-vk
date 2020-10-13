import Foundation

protocol SaveServiveInterface {
    func saveUserData(_ userProfile: UserProfile)
    func getUserData(userId: Int) -> UserProfile?
    
    func saveUserGroups(_ userGroups: [UserGroup])
    func getUserGroups() -> [UserGroup]?
}

