//
//  RealmSaveService.swift
//  VK2
//
//  Created by Marat Khanbekov on 11.10.2020.
//  Copyright © 2020 Marat. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

protocol RealmOutput: class {
    func update(_ changes: RealmCollectionChange<Results<UserGroupsObject>>)
}


class RealmSaveService: SaveServiveInterface {

    let realm: Realm
    var token: NotificationToken?
    weak var delegate: RealmOutput?
    
    init() {
        let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        self.realm = try! Realm(configuration: config)
        debugPrint(realm.configuration.fileURL)
        
    }
    
    func saveUserData(_ userProfile: UserProfile) {
        do {
            let userProfileObject = UserProfileObject()
            
            userProfileObject.id = userProfile.id
            userProfileObject.first_name = userProfile.first_name
            userProfileObject.last_name = userProfile.last_name
            userProfileObject.photo_100 = userProfile.photo_100
            userProfileObject.followers_count = userProfile.followers_count
            
            realm.beginWrite()
            realm.add(userProfileObject)
            try realm.commitWrite()
            debugPrint("Данные записаны в Realm")
        }
        catch {
            print(error)
        }
    }
    
    func getUserData(userId: Int) -> UserProfile? {
        guard let userProfileObject = realm.objects(UserProfileObject.self).filter("id == %@", userId).first else { return nil }
        let userProfile = UserProfile(id: userProfileObject.id,
                                      first_name: userProfileObject.first_name,
                                      last_name: userProfileObject.last_name,
                                      photo_100: userProfileObject.photo_100,
                                      followers_count: userProfileObject.followers_count)
        debugPrint("Данные полученые из Realm")
        return userProfile
    }

    func saveUserGroups(_ userGroups: [UserGroup]) {
        do {
            let userGroupsObject = UserGroupsObject()
            
            userGroups.forEach({ userGroup in
                let userGroupObject = UserGroupObject()
                userGroupObject.name = userGroup.name
                userGroupObject.photo_100 = userGroup.photo_100
                userGroupsObject.groups.append(userGroupObject)
            })
            realm.beginWrite()
            realm.add(userGroupsObject)
            try realm.commitWrite()
            debugPrint("Данные записаны в Realm")
        }
        catch {
            print(error)
        }
    }
    
    func getUserGroups() -> [UserGroup]? {
        
        // Формируем запрос
        let userGroupsObject = realm.objects(UserGroupsObject.self)
        
        
        // Подписываемся и в случае обновлений запускаем в делегате метод
        self.token = userGroupsObject.observe({[weak self] (changes) in
            self?.delegate?.update(changes)
            
        })
        
        debugPrint("Данные полученые из Realm")
        guard let userGroupsObjectFirst = userGroupsObject.first else { return nil }
        return userGroupsObjectFirst.groups.map { UserGroup(name: $0.name, photo_100: $0.photo_100) }
    }
}
