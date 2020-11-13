import Foundation

struct NewsPosts {
    let posts: [NewsPost]
}

struct NewsPost {
    let authorPhoto: String
    let authorName: String
    let likesAmount: Int
    let commentsAmount: Int
    let viewsAmount: Int
    let repostsAmount: Int
    let postText: String
    let postAttachments: [String]
    let postPhoto: String
}


// MARK: - Newsfeed
struct NewsPostFeed: Codable {
    let response: PostResponse?
}

// MARK: - Response
struct PostResponse: Codable {
    let items: [Item]?
    let profiles: [Profile]?
    let groups: [Group]?

    enum CodingKeys: String, CodingKey {
        case items, profiles, groups
    }
}

// MARK: - Group
struct Group: Codable {
    let id: Int?
    let name, screenName: String?
    let isClosed: Int?
    let type: String?
    let photo50, photo100, photo200: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case screenName = "screen_name"
        case isClosed = "is_closed"
        case type
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case photo200 = "photo_200"
    }
}

// MARK: - Item
struct Item: Codable {
    let sourceID, date: Int?
    let canDoubtCategory, canSetCategory: Bool?
    let postType, text: String?
    let markedAsAds: Int?
    let attachments: [Attachment]?
    let comments, likes, reposts, views: Comments?
    let isFavorite: Bool?
    let postID: Int?
    let type: String?

    enum CodingKeys: String, CodingKey {
        case sourceID = "source_id"
        case date
        case canDoubtCategory = "can_doubt_category"
        case canSetCategory = "can_set_category"
        case postType = "post_type"
        case text
        case markedAsAds = "marked_as_ads"
        case attachments, comments, likes, reposts, views
        case isFavorite = "is_favorite"
        case postID = "post_id"
        case type
    }
}

// MARK: - Attachment
struct Attachment: Codable {
    let type: String?
    let photo: Photo?
    let video: Video?
}

// MARK: - Photo
struct Photo: Codable {
    let albumID, date, id, ownerID: Int?
    let hasTags: Bool?
    let accessKey: String?
    let postID: Int?
    let sizes: [Size]?
    let text: String?
    let userID: Int?

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case date, id
        case ownerID = "owner_id"
        case hasTags = "has_tags"
        case accessKey = "access_key"
        case postID = "post_id"
        case sizes, text
        case userID = "user_id"
    }
}

// MARK: - Size
struct Size: Codable {
    let height: Int?
    let url: String?
    let type: String?
    let width, withPadding: Int?

    enum CodingKeys: String, CodingKey {
        case height, url, type, width
        case withPadding = "with_padding"
    }
}

// MARK: - Video
struct Video: Codable {
    let accessKey: String?
    let canComment, canLike, canRepost, canSubscribe: Int?
    let canAddToFaves, canAdd, comments, date: Int?
    let videoDescription: String?
    let duration: Int?
    let image: [Size]?
    let id, ownerID: Int?
    let title: String?
    let isFavorite: Bool?
    let trackCode, type: String?
    let views, live, upcoming: Int?

    enum CodingKeys: String, CodingKey {
        case accessKey = "access_key"
        case canComment = "can_comment"
        case canLike = "can_like"
        case canRepost = "can_repost"
        case canSubscribe = "can_subscribe"
        case canAddToFaves = "can_add_to_faves"
        case canAdd = "can_add"
        case comments, date
        case videoDescription = "description"
        case duration, image, id
        case ownerID = "owner_id"
        case title
        case isFavorite = "is_favorite"
        case trackCode = "track_code"
        case type, views, live, upcoming
    }
}

// MARK: - Comments
struct Comments: Codable {
    let count: Int?
}

// MARK: - Profile
struct Profile: Codable {
    let firstName: String?
    let id: Int?
    let lastName: String?
    let canAccessClosed, isClosed: Bool?
    let sex: Int?
    let screenName: String?
    let photo50, photo100: String?
    let online: Int?

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case id
        case lastName = "last_name"
        case canAccessClosed = "can_access_closed"
        case isClosed = "is_closed"
        case sex
        case screenName = "screen_name"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case online
    }
}
