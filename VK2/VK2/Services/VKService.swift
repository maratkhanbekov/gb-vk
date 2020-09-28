import Foundation
import Alamofire


class VKService {
    var baseUrl = "https://api.vk.com/method/"
    let v = 5.124
    
    func getFriends(userId: Int, accessToken: String) {
        
        let methodName = "friends.get"
        let urlString = baseUrl + methodName
        
        let parameters: Parameters = [
            "user_id": userId,
            "access_token": accessToken,
            "v": v
        ]
        
        AF.request(urlString, method: .get, parameters: parameters).response { response in
            debugPrint("================== User Friends ==================")
            debugPrint(response)
        }
    }
    
    func getPhotos(userId: Int, accessToken: String) {
        let methodName = "photos.getAll"
        let urlString = baseUrl + methodName
        
        let parameters: Parameters = [
            "owner_id": userId,
            "access_token": accessToken,
            "v": v
        ]
        AF.request(urlString, method: .get, parameters: parameters).response { response in
            debugPrint("================== User Photos ==================")
            debugPrint(response)
        }
    }
    
    func getGroups(userId: Int, accessToken: String) {
        let methodName = "groups.get"
        let urlString = baseUrl + methodName
        
        let parameters: Parameters = [
            "user_id": userId,
            "access_token": accessToken,
            "v": v
        ]
        AF.request(urlString, method: .get, parameters: parameters).response { response in
            debugPrint("================== User Groups ==================")
            debugPrint(response)
        }
    }
    
    func searchGroups(q: String, accessToken: String) {
        let methodName = "groups.search"
        let urlString = baseUrl + methodName
        
        let parameters: Parameters = [
            "q": q,
            "access_token": accessToken,
            "v": v
        ]
        AF.request(urlString, method: .get, parameters: parameters).response { response in
            debugPrint("================== Founded Groups ==================")
            debugPrint(response)
        }
    }
    
    
}
