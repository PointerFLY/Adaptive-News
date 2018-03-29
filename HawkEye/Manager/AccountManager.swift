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
    
    var isLogin: Bool {
        return KeyValueStore.token != nil
    }
    
    func login(userName: String, password: String) {
        KeyValueStore.token = userName + password
        NotificationCenter.default.post(name: NotificationNames.kLoginStatusChanged, object: self)
    }
    
    func register(user: RegisteringUser, success: @escaping () -> Void, failure: @escaping (NSError) -> Void) {
        let dbUser = user.toDB()
        
        DispatchQueue.global().async {
            do {
                let realm = try Realm()
                try realm.write {
                    realm.add(dbUser)
                }
            } catch let error as NSError {
                DispatchQueue.main.async {
                    failure(error)
                }
            }
            
            DispatchQueue.main.async {
                success()
            }
        }
    }
    
    func logout() {
        KeyValueStore.token = nil
        NotificationCenter.default.post(name: NotificationNames.kLoginStatusChanged, object: self);
    }
}
