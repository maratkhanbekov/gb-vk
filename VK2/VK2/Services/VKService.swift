import Foundation
import Alamofire


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
            
            // Если все ок, то выполнить полученный closure
            callback(userProfile!)
        }
        
        
    }
}

