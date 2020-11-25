import Foundation
import PromiseKit

protocol SaveServiveInterface {
    func saveUserData(_ userProfile: UserProfile)
    func getUserData() -> Promise<UserProfile>
    
    func saveUserGroups(_ userGroups: [UserGroup])
    func getUserGroups() -> Promise<[UserGroup]>
}

