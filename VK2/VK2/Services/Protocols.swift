import Foundation
import PromiseKit

protocol SaveServiveInterface {
    func saveUserData(_ userProfile: UserProfile)
    func getUserData(userId: Int, accessToken: String, callback: @escaping(UserProfile) -> Void)
    
    func saveUserGroups(_ userGroups: [UserGroup])
    func getUserGroups(userId: Int, accessToken: String) -> Promise<[UserGroup]>
}

