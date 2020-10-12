import Foundation

struct UserPhotosRootResponse: Codable {
    let response: UserPhotosGeneralInfo
}

struct UserPhotosGeneralInfo: Codable {
    let count: Int
    let photos: [UserPhotos]
    
    enum CodingKeys: String, CodingKey {
        case photos = "items"
        case count = "count"
    }
}

struct UserPhotos: Codable {
    let sizes: [UserPhotosSize]
}

struct UserPhotosSize: Codable {
    let height: Int
    let width: Int
    let url: String
    let type: String
}
