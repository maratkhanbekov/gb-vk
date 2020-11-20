import Foundation
import Realm
import RealmSwift

struct UserGroupsRootResponse: Codable {
    let response: UserGroupsGeneralInfo
}

struct UserGroupsGeneralInfo: Codable {
    let items: [UserGroup]
}

struct UserGroup: Codable {
    let name: String
    let photo100: String
    
    init(name: String, photo_100: String) {
        self.name = name
        self.photo100 = photo_100
    }
    
}

class UserGroupsObject: Object {
    let groups = List<UserGroupObject>()
}

class UserGroupObject: Object {
    @objc dynamic var name = ""
    @objc dynamic var photo_100 = ""
}
