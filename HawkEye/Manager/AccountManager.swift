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
                        KeyValueStore.token = (userName + Date().description + password).md5()
                        KeyValueStore.lastPassword = password
                        KeyValueStore.lastUserName = userName
                        let user = User(dbUser: dbUser)
                        DispatchQueue.main.async {
                            self.currentUser = user
                            success()
                            NotificationCenter.default.post(name: NotificationNames.kLoginStatusChanged, object: self)
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
                let isNotExist = (nil == realm.object(ofType: DBUser.self, forPrimaryKey: user.userName))
                guard isNotExist else {
                    DispatchQueue.main.async {
                        failure("User already exist")
                    }
                    return
                }
                
                try realm.write {
                    realm.add(dbUser)
                }
                
                self.login(userName: user.userName!, password: user.password!, success: {
                    success()
                    NotificationCenter.default.post(name: NotificationNames.kLoginStatusChanged, object: self)
                }, failure: { message in
                    failure("Register failed")
                })
            } catch let error as NSError {
                DispatchQueue.main.async {
                    failure(error.localizedDescription)
                }
            }
        }
    }
    
    func logout() {
        KeyValueStore.token = nil
        currentUser = nil
        NotificationCenter.default.post(name: NotificationNames.kLoginStatusChanged, object: self);
    }
}
