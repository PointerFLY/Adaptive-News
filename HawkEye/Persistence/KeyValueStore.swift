//
//  UserSettings.swift
//  hawkEye
//
//  Created by PointerFLY on 23/03/2018.
//  Copyright © 2018 PointerFLY. All rights reserved.
//

import UIKit
import SwiftyUserDefaults
import KeychainAccess
import Log

extension DefaultsKeys {
    static let userName = DefaultsKey<String?>("userName")
    static let token = DefaultsKey<String?>("token")
    static let gender = DefaultsKey<Int?>("gender")
}

class KeyValueStore {
    
    private static let keychain = Keychain(service: Bundle.main.bundleIdentifier!)
    
    private struct KeychainKeys {
        static let kPassword = "kPassword"
    }
    
    static var token: String? {
        get {
            return Defaults[.token]
        }
        set {
            Defaults[.token] = newValue
            Defaults.synchronize()
        }
    }
    
    static var lastUserName: String? {
        get {
            return Defaults[.userName]
        }
        set {
            Defaults[.userName] = newValue
            Defaults.synchronize();
        }
    }
    
    static var lastPassword: String? {
        get {
            do {
                return try keychain.get(KeychainKeys.kPassword)
            } catch let error  {
                Log.error(error)
                return nil
            }
        }
        set {
            do {
                if let password = newValue {
                    try keychain.set(password, key: KeychainKeys.kPassword)
                } else {
                    try keychain.remove(KeychainKeys.kPassword)
                }
            } catch let error {
                Log.error(error)
            }
        }
    }
}
