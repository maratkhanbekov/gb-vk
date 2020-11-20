import Foundation
import Firebase
import PromiseKit
import CodableFirebase

class FirebaseService: SaveServiveInterface {
    
    let sessionService = SessionService()
    
    let vkService = VKService()
    
    func getUserData(userId: Int) -> UserProfile? {
        fatalError("use async method")
    }
    
    let userListRef = Database.database().reference().child("user-list")
    let groupsListRef = Database.database().reference().child("groups-list")
    
    func saveUserData(_ userProfile: UserProfile) {
        
        let value = [
            "first_name": userProfile.first_name,
            "last_name": userProfile.last_name,
            "photo_100": userProfile.photo_100,
            "followers_count": userProfile.followers_count,
            "id": userProfile.id,
        ] as [String : Any]
        
        userListRef.childByAutoId().setValue(value)
        
    }
    
    func getUserData() -> Promise<UserProfile> {
        
        let promise = Promise<UserProfile> { resolver in
            
            userListRef.observeSingleEvent(of: .value) { (snapshot) in
                var output: UserProfile
                let children = snapshot.children
                
                guard let userId = self.sessionService.getUsedId() else {
                    return resolver.reject(PromiseErrors.userNotFound)
                }
                
                // Поиск пользователя
                for child in children {
                    
                    guard let snap = child as? DataSnapshot,
                          let dict = snap.value as? [String: Any] else { return }
                    
                    if userId == dict["id"] as! Int {
                        do {
                            output = try FirebaseDecoder().decode(UserProfile.self, from: dict)
                            debugPrint("Данные User из Firebase")
                            resolver.fulfill(output)
                        } catch {
                            resolver.reject(PromiseErrors.userNotFound)
                        }
                    }
                }
                
                // Если не нашли, то получаем данные из ВК
                self.vkService.getUserInfo(callback: {[weak self] userProfile in
                    var output: UserProfile
                    
                    // Сохраняем в базу
                    self?.saveUserData(userProfile)
                    
                    output = UserProfile(id: userProfile.id, first_name: userProfile.first_name, last_name: userProfile.last_name, photo_100: userProfile.photo_100, followers_count: userProfile.followers_count)
                    resolver.fulfill(output)
                })
                
            }
        }
        
        return promise
    }
    
    func saveUserGroups(_ userGroups: [UserGroup]) {
        for userGroup in userGroups {
            let value = [
                "name": userGroup.name,
                "photo_100": userGroup.photo100
            ]
            groupsListRef.childByAutoId().setValue(value)
        }
    }
    
    func getUserGroups() -> Promise<[UserGroup]> {
        let promise = Promise<[UserGroup]> { resolver in
            groupsListRef.observeSingleEvent(of: .value) { (snapshot) in
                var output = [UserGroup]()
                let children = snapshot.children
                
                for child in children {
                    let snap = child as! DataSnapshot
                    let dict = snap.value as! [String: Any]
                    
                    let name = dict["name"] as! String
                    let photo_100 = dict["photo_100"] as! String
                    
                    let userGroup = UserGroup(name: name, photo_100: photo_100)
                    output.append(userGroup)
                    debugPrint("Данные User Groups из Firebase")
                }
                resolver.fulfill(output)
            }
        }
        return promise
    }
}
