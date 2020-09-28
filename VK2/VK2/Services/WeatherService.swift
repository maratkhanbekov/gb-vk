
import Foundation
import Alamofire

class WeatherService {
    var baseUrl = "samples.openweathermap.org"
    var appId = "b1b15e88fa797225412429c1c50c122a1"
    
    func getWeather(city: String, callback: @escaping (WeatherModel) -> Void) {
        let urlString = "https://\(baseUrl)/data/2.5/forecast"
        let parameters: Parameters = [
            "q"     : city,
            "appid" : appId
        ]
        
        AF.request(urlString, method: .get, parameters: parameters).responseDecodable(of: WeatherModel.self) { response in
            switch response.result {
                
            case let .success(model):
                
                // Если все ок, то выполнить полученный closure
                callback(model)
            
            case let .failure(error):
                debugPrint(error.localizedDescription)
            }
        }
        
    }
}

struct WeatherModel: Decodable {
    let cod: String
    let message: Double
    let cnt: Int
    let city: City
}

// MARK: - City
struct City: Codable {
    let id: Int
    let name: String
//    let coord: Coord
    let country: String
}


//func alomofireTest() {
//    let urlString = "https://samples.openweathermap.org/data/2.5/forecast?q=Moscow,DE&appid=b1b15e88fa797225412429c1c50c122a1"
//
//
//         let urlAddress = "https://samples.openweathermap.org"

//

//}
