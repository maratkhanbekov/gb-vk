import Foundation
import RealmSwift

struct User: Codable {
    let usedId: Int
    let accessToken: String
}

struct UserRootResponse: Decodable {
    let response: [UserProfile]
}

class UserProfile: Object, Decodable {
    @objc dynamic var id = 0
    @objc dynamic var first_name = ""
    @objc dynamic var last_name = ""
//    @objc dynamic var city: UserCity
    @objc dynamic var photo_100 = ""
    @objc dynamic var followers_count = 0
}

class UserCity: Object, Decodable {
    @objc dynamic var id = 0
    @objc dynamic var title = ""
}

struct UserGroupsRootResponse: Decodable {
    let response: UserGroupsGeneralInfo
}

struct UserGroupsGeneralInfo: Decodable {
    let count: Int
    let items: [UserGroups]
}

struct UserGroups: Decodable {
    let name: String
}

