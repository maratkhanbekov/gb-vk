import Foundation
import PromiseKit

protocol SaveServiveInterface {
    func saveUserData(_ userProfile: UserProfile)
    func getUserData(callback: @escaping(UserProfile) -> Void)
    
    func saveUserGroups(_ userGroups: [UserGroup])
    func getUserGroups() -> Promise<[UserGroup]>
}

