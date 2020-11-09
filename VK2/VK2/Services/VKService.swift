import Foundation
import Alamofire
import RealmSwift

class VKService {
    var baseUrl = "https://api.vk.com/method/"
    let v = 5.124
    
    let dispatchGroup = DispatchGroup()

    func getNewsPost(userId: Int, accessToken: String, callback: @escaping (NewsPostFeed) -> Void) {
        let methodName = "newsfeed.get"
        let urlString = baseUrl + methodName
        
        let parameters: Parameters = [
            "owner_id": userId,
            "access_token": accessToken,
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
    
    
    func getNewsPhoto(userId: Int, accessToken: String, callback: @escaping (NewsPhotoFeed) -> Void) {
        let methodName = "newsfeed.get"
        let urlString = baseUrl + methodName
        
        let parameters: Parameters = [
            "owner_id": userId,
            "access_token": accessToken,
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
    
    func getUserPhotos(userId: Int, accessToken: String, callback: @escaping ([String]) -> Void) {
        let methodName = "photos.getAll"
        let urlString = baseUrl + methodName
        
        let parameters: Parameters = [
            "owner_id": userId,
            "access_token": accessToken,
            "v": v,
            "extended": 1,
            "count": 10
        ]
        
        AF.request(urlString, method: .get, parameters: parameters).responseData { response in
            let data = response.data!
            let decoder = JSONDecoder()
            
            let userPhotosRootResponse = try? decoder.decode(UserPhotosRootResponse.self, from: data)
            
            let userPhotos = userPhotosRootResponse?.response.photos.map{ $0.sizes.filter { size in size.type == "w"} }.compactMap { $0.first }
            var userPhotosURLs = [String]()
            userPhotos?.forEach { userPhotosURLs.append(String($0.url)) }
            
            callback(userPhotosURLs)
            
        }
    }
    
    func getUserGroups(userId: Int, accessToken: String, callback: @escaping ([UserGroup]) -> Void) {
        let methodName = "groups.get"
        let urlString = baseUrl + methodName
        
        let parameters: Parameters = [
            "users_id": userId,
            "access_token": accessToken,
            "v": v,
            "extended": 1,
            "fields": "name, photo_100"
        ]
        
        
        AF.request(urlString, method: .get, parameters: parameters).responseData { response in
            
            let data = response.data!
            let decoder = JSONDecoder()
            
            let userGroupsRootResponse = try? decoder.decode(UserGroupsRootResponse.self, from: data)
            let userGroups = userGroupsRootResponse?.response.items
            // Если все ок, то выполнить полученный closure
            debugPrint("Данные получены из VK")
            callback(userGroups!)
        }
    }
    
    func getUserInfo(userId: Int, accessToken: String, callback: @escaping (UserProfile) -> Void) {
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
    
    // Сохранение данных в Realm
    //    func saveUserData(_ userProfile: UserProfile) {
    //        do {
    //
    //            // получаем объект класса Realm для доступа к хранилищу.
    //            let realm = try Realm()
    //            // начнем сеанс записи
    //            realm.beginWrite()
    //            //  добавим объект
    //            realm.add(userProfile)
    //            // завершим сеанс записи
    //            try realm.commitWrite()
    //            debugPrint("Данные получены из vk.com и сохранены")
    //        }
    //        catch {
    //            print(error)
    //        }
    //    }
    
    // Чтение данных из Realm
    //    func getUserData() -> UserProfile? {
    //        print(Realm.Configuration.defaultConfiguration.fileURL!)
    //        debugPrint("Данные получены из Realm")
    //        let realm = try! Realm()
    //        guard let userProfile = realm.objects(UserProfileObject.self).first else { return nil }
    //        return userProfile
    //
    //    }
}

