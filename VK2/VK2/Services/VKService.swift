import Foundation
import Alamofire
import RealmSwift
import PromiseKit

class VKService {
    var baseUrl = "https://api.vk.com/method/"
    let v = 5.124
    
    private let userId: Int = {
        let sessionService = SessionService()
        guard let id = sessionService.getUsedId() else { return 0 }
        return id
    }()
    
    private let accessToken: String = {
        let sessionService = SessionService()
        guard let token = sessionService.getToken() else { return "" }
        return token
    }()
    
    func getNewsPost(callback: @escaping (NewsPostFeed) -> Void) {
        
        let methodName = "newsfeed.get"
        let urlString = baseUrl + methodName
        
        let parameters: Parameters = [
            "owner_id": self.userId,
            "access_token": self.accessToken,
            "v": v,
            "filters": "post",
            "count": 5,
        ]
        
        AF.request(urlString, method: .get, parameters: parameters).response { response in
            print(response.request)
            let decoder = JSONDecoder()
            let newsPostFeed: NewsPostFeed = try! decoder.decode(NewsPostFeed.self, from: response.data!)
            callback(newsPostFeed)
        }
    }
    
    
    func getNewsPhoto(callback: @escaping (NewsPhotoFeed) -> Void) {
        
        let methodName = "newsfeed.get"
        let urlString = baseUrl + methodName
        
        let parameters: Parameters = [
            "owner_id": self.userId,
            "access_token": self.accessToken,
            "v": v,
            "filters": "photos",
            "count": 3,
        ]
        
        AF.request(urlString, method: .get, parameters: parameters).response { response in
            print(response.request)
            let decoder = JSONDecoder()
            let newsPhotoFeed: NewsPhotoFeed = try! decoder.decode(NewsPhotoFeed.self, from: response.data!)
            callback(newsPhotoFeed)
        }
    }
    
    
    func getUserPhotos() -> Promise<[String]> {
        let methodName = "photos.getAll"
        let urlString = baseUrl + methodName
        
        let parameters: Parameters = [
            "owner_id": self.userId,
            "access_token": self.accessToken,
            "v": v,
            "extended": 1,
            "count": 10
        ]
        
        let promise = Promise<[String]> { resolver in
            
            AF.request(urlString, method: .get, parameters: parameters).responseData { response in
                switch response.result {
                case .success(let data):
                    let decoder = JSONDecoder()
                    
                    let userPhotosRootResponse = try? decoder.decode(UserPhotosRootResponse.self, from: data)
                    
                    let userPhotos = userPhotosRootResponse?.response.photos.map{ $0.sizes.filter { size in size.type == "w"} }.compactMap { $0.first }
                    var userPhotosURLs = [String]()
                    userPhotos?.forEach { userPhotosURLs.append(String($0.url)) }
                    resolver.fulfill(userPhotosURLs)
                case .failure(let error):
                    resolver.reject(error)
                }
            }
        }
        return promise
    }
    
    func getUserGroups() -> Promise<[UserGroup]> {
        let methodName = "groups.get"
        let urlString = baseUrl + methodName
        let parameters: Parameters = [
            "users_id": self.userId,
            "access_token": self.accessToken,
            "v": v,
            "extended": 1,
            "fields": "name, photo_100"
        ]
        
        let promise = Promise<[UserGroup]> { resolver in
            
            AF.request(urlString, method: .get, parameters: parameters).responseData { response in
                switch response.result {
                
                case .success(let data):
                    let decoder = JSONDecoder()
                    let userGroupsRootResponse = try? decoder.decode(UserGroupsRootResponse.self, from: data)
                    let userGroups = userGroupsRootResponse?.response.items
                    // Если все ок, то выполнить полученный closure
                    debugPrint("Данные получены из VK")
                    resolver.fulfill(userGroups!)
                    
                case .failure(let error):
                    resolver.reject(error)
                }
                
            }
        }
        
        return promise
        
    }
    
    func getUserInfo(callback: @escaping (UserProfile) -> Void) {
        let methodName = "users.get"
        let urlString = baseUrl + methodName
        
        let parameters: Parameters = [
            "users_id": userId,
            "access_token": accessToken,
            "v": v,
            "fields": "sex, city, photo_100, followers_count",
        ]
        
        
        AF.request(urlString, method: .get, parameters: parameters).responseData { response in
            
            let data = response.data!
            let decoder = JSONDecoder()
            let userRootResponse = try? decoder.decode(UserRootResponse.self, from: data)
            let userProfile = userRootResponse?.response[0]
            
            guard let userProfileUnWrapped = userProfile else { return }
            
            //            self.saveUserData(userProfileUnWrapped)
            
            // Если все ок, то выполнить полученный closure
            
            debugPrint("Данные получены из VK")
            callback(userProfileUnWrapped)
        }
    }
}
