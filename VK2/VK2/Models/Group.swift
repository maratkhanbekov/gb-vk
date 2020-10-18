import Foundation
import Realm
import RealmSwift

struct UserGroupsRootResponse: Decodable {
    let response: UserGroupsGeneralInfo
}

struct UserGroupsGeneralInfo: Decodable {
    let items: [UserGroup]
}

struct UserGroup: Decodable {
    let name: String
    let photo_100: String
    
    init(name: String, photo_100: String) {
        self.name = name
        self.photo_100 = photo_100
    }
}

class UserGroupsObject: Object {
    let groups = List<UserGroupObject>()
}

class UserGroupObject: Object {
    @objc dynamic var name = ""
    @objc dynamic var photo_100 = ""
}
