//
//  AccountManager.swift
//  hawkEye
//
//  Created by PointerFLY on 23/03/2018.
//  Copyright © 2018 PointerFLY. All rights reserved.
//

import UIKit
import RealmSwift

class AccountManager {
    
    static let shared = AccountManager()
    
    private init() {}
    
    var currentUser: User?
    
    var isLogin: Bool {
        return KeyValueStore.token != nil
    }
    
    func login(userName: String, password: String, success: @escaping () -> Void, failure: @escaping (String) -> Void) {
        DispatchQueue.global().async {
            do {
                let realm = try Realm()
                let dbUser = realm.object(ofType: DBUser.self, forPrimaryKey: userName)
                if let dbUser = dbUser {
                    if dbUser.password == (userName + password).md5() {
                        KeyValueStore.token = (userName + password).md5()
                        KeyValueStore.lastPassword = password
                        KeyValueStore.lastUserName = userName
                        let user = User(dbUser: dbUser)
                        DispatchQueue.main.async {
                            self.currentUser = user
                            NotificationCenter.default.post(name: NotificationNames.kLoginStatusChanged, object: self)
                            success()
                        }
                    } else {
                        DispatchQueue.main.async {
                            failure("Password incorrect")
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        failure("User name not exist")
                    }
                }
            } catch let error as NSError {
                DispatchQueue.main.async {
                    failure(error.localizedDescription)
                }
            }
        }
    }
    
    func register(user: RegisteringUser, success: @escaping () -> Void, failure: @escaping (String) -> Void) {
        let dbUser = user.toDB()
        
        DispatchQueue.global().async {
            do {
                let realm = try Realm()
                try realm.write {
                    realm.add(dbUser)
                }
            } catch let error as NSError {
                DispatchQueue.main.async {
                    failure(error.localizedDescription)
                }
            }
            
            DispatchQueue.main.async {
                success()
            }
        }
    }
    
    func logout() {
        KeyValueStore.token = nil
        currentUser = nil
        NotificationCenter.default.post(name: NotificationNames.kLoginStatusChanged, object: self);
    }
}
