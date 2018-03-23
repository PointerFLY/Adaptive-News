//
//  AccountManager.swift
//  hawkEye
//
//  Created by PointerFLY on 23/03/2018.
//  Copyright © 2018 PointerFLY. All rights reserved.
//

import UIKit

class AccountManager {
    
    static let shared = AccountManager()
    
    private init() { }
    
    var isLogin: Bool {
        return KeyValueStore.token != nil
    }
    
    func logout() {
        KeyValueStore.token = nil
        NotificationCenter.default.post(name: NotificationNames.kLoginStatusChanged, object: nil);
    }
}
