import Foundation

// MARK: - Newsfeed
struct NewsPhotoFeed: Codable {
    let response: PhotoResponse?
}

// MARK: - Response
struct PhotoResponse: Codable {
    let items: [ResponseItem]?
    let profiles: [Profile]?
    let nextFrom: String?

    enum CodingKeys: String, CodingKey {
        case items, profiles
        case nextFrom = "next_from"
    }
}

// MARK: - ResponseItem
struct ResponseItem: Codable {
    let sourceID, date: Int?
    let photos: Photos?
    let postID: Int?
    let type: String?

    enum CodingKeys: String, CodingKey {
        case sourceID = "source_id"
        case date, photos
        case postID = "post_id"
        case type
    }
}

// MARK: - Photos
struct Photos: Codable {
    let count: Int?
    let items: [PhotosItem]?
}

// MARK: - PhotosItem
struct PhotosItem: Codable {
    let albumID, date, id, ownerID: Int?
    let hasTags: Bool?
    let accessKey: String?
    let sizes: [Size]?
    let text: String?
    let likes: Likes?
    let reposts: Reposts?
    let comments: Comments?
    let canComment, canRepost: Int?

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case date, id
        case ownerID = "owner_id"
        case hasTags = "has_tags"
        case accessKey = "access_key"
        case sizes, text, likes, reposts, comments
        case canComment = "can_comment"
        case canRepost = "can_repost"
    }
}

// MARK: - Likes
struct Likes: Codable {
    let userLikes, count: Int?

    enum CodingKeys: String, CodingKey {
        case userLikes = "user_likes"
        case count
    }
}

// MARK: - Reposts
struct Reposts: Codable {
    let count, userReposted: Int?

    enum CodingKeys: String, CodingKey {
        case count
        case userReposted = "user_reposted"
    }
}


// MARK: - OnlineInfo
struct OnlineInfo: Codable {
    let visible: Bool?
    let lastSeen: Int?
    let isOnline: Bool?
    let appID: Int?
    let isMobile: Bool?

    enum CodingKeys: String, CodingKey {
        case visible
        case lastSeen = "last_seen"
        case isOnline = "is_online"
        case appID = "app_id"
        case isMobile = "is_mobile"
    }
}

// MARK: - Encode/decode helpers

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}
