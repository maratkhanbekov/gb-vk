import Foundation
import Realm
import RealmSwift

struct User: Codable {
    let usedId: Int
    let accessToken: String
}

struct UserRootResponse: Decodable {
    let response: [UserProfile]
}

struct UserProfile: Decodable {
    let id: Int
    let first_name: String
    let last_name: String
    let photo_100: String
    let followers_count: Int
}


class UserProfileObject: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var first_name = ""
    @objc dynamic var last_name = ""
    @objc dynamic var photo_100 = ""
    @objc dynamic var followers_count = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class UserCityObject: Object {
    @objc dynamic var id = 0
    @objc dynamic var title = ""
}
