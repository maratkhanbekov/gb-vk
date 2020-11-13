//
//  FirebaseService.swift
//  VK2
//
//  Created by Marat Khanbekov on 17.10.2020.
//  Copyright © 2020 Marat. All rights reserved.
// 

import Foundation
import Firebase
import PromiseKit


class FirebaseService: SaveServiveInterface {
   
    let vkService = VKService()
    
    func getUserData(userId: Int) -> UserProfile? {
        fatalError("use async method")
    }
    
    let userListRef = Database.database().reference().child("user-list")
    let groupsListRef = Database.database().reference().child("groups-list")
    
    func saveUserData(_ userProfile: UserProfile) {
        
        let value = [
            "first_name": userProfile.first_name,
            "last_name": userProfile.last_name,
            "photo_100": userProfile.photo_100,
            "followers_count": userProfile.followers_count,
            "id": userProfile.id,
        ] as [String : Any]
        
        userListRef.childByAutoId().setValue(value)
        
    }
    
    func getUserData(userId: Int, accessToken: String, callback: @escaping(UserProfile) -> Void) {
        userListRef.observeSingleEvent(of: .value) { (snapshot) in
            var output: UserProfile
            let children = snapshot.children
            
            // Поиск пользователя
            for child in children {
                let snap = child as! DataSnapshot
                let dict = snap.value as! [String: Any]
                
                if userId == dict["id"] as! Int {
                    let first_name = dict["first_name"] as! String
                    let last_name = dict["last_name"] as! String
                    let photo_100 = dict["photo_100"] as! String
                    let followers_count = dict["followers_count"] as! Int
                    
                    output = UserProfile(id: userId, first_name: first_name, last_name: last_name, photo_100: photo_100, followers_count: followers_count)
                    debugPrint("Данные User из Firebase")
                    callback(output)
                    return
                }
            }
            
            // Если не нашли, то получаем данные из ВК
            self.vkService.getUserInfo(userId: userId, accessToken: accessToken, callback: {[weak self] userProfile in
                var output: UserProfile
                
                // Сохраняем в базу
                self?.saveUserData(userProfile)
                
                output = UserProfile(id: userProfile.id, first_name: userProfile.first_name, last_name: userProfile.last_name, photo_100: userProfile.photo_100, followers_count: userProfile.followers_count)
                
                callback(output)
                return
            })
            
        }
    }
    
    func saveUserGroups(_ userGroups: [UserGroup]) {
        for userGroup in userGroups {
            let value = [
                "name": userGroup.name,
                "photo_100": userGroup.photo_100
            ]
            groupsListRef.childByAutoId().setValue(value)
        }
    }
    
    func getUserGroups(userId: Int, accessToken: String) -> Promise<[UserGroup]> {
        let promise = Promise<[UserGroup]> { resolver in
            groupsListRef.observeSingleEvent(of: .value) { (snapshot) in
                var output = [UserGroup]()
                let children = snapshot.children
                
                for child in children {
                    let snap = child as! DataSnapshot
                    let dict = snap.value as! [String: Any]
                    
                    let name = dict["name"] as! String
                    let photo_100 = dict["photo_100"] as! String
                    
                    let userGroup = UserGroup(name: name, photo_100: photo_100)
                    output.append(userGroup)
                    debugPrint("Данные User Groups из Firebase")
                }
                resolver.fulfill(output)
            }
        }
        return promise
    }
}
