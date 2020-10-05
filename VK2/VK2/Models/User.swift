import Foundation

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
    let city: UserCity
    let photo_100: String
    let followers_count: Int
}

struct UserCity: Decodable {
    let id: Int
    let title: String
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

