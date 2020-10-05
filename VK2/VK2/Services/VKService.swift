import Foundation
import Alamofire
import RealmSwift

class VKService {
    var baseUrl = "https://api.vk.com/method/"
    let v = 5.124
    
    func getUserGroups(userId: Int, accessToken: String, callback: @escaping ([UserGroups]) -> Void) {
        let methodName = "groups.get"
        let urlString = baseUrl + methodName
        
        let parameters: Parameters = [
            "users_id": userId,
            "access_token": accessToken,
            "v": v,
            "extended": 1,
        ]
    

        AF.request(urlString, method: .get, parameters: parameters).responseData { response in
    
            let data = response.data!
            let decoder = JSONDecoder()
            
            let userGroupsRootResponse = try? decoder.decode(UserGroupsRootResponse.self, from: data)
            let userGroups = userGroupsRootResponse?.response.items
//
            // Если все ок, то выполнить полученный closure
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
            
            self.saveUserData(userProfileUnWrapped)
            
            // Если все ок, то выполнить полученный closure
            callback(userProfileUnWrapped)
        }
    }
    
    // Сохранение данных в Realm
    func saveUserData(_ userProfile: UserProfile) {
        do {
            
            // получаем объект класса Realm для доступа к хранилищу.
            let realm = try Realm()
            // начнем сеанс записи
            realm.beginWrite()
            //  добавим объект
            realm.add(userProfile)
            // завершим сеанс записи
            try realm.commitWrite()
            debugPrint("Данные получены из vk.com и сохранены")
        }
        catch {
            print(error)
        }
    }
    
    // Чтение данных из Realm
    func getUserData() -> UserProfile? {
        
        let realm = try! Realm()
        guard let userProfile = realm.objects(UserProfile.self).first else { return nil }
        return userProfile
        debugPrint("Данные получены из Realm")
    }
}

