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
}

class KeyValueStore {
    
    private static let keychain = Keychain(service: Bundle.main.bundleIdentifier!)
    
    private struct KeychainKeys {
        static let kToken = "kToken"
    }
    
    static var userName: String? {
        get {
            return Defaults[.userName]
        }
        set {
            Defaults[.userName] = newValue
            Defaults.synchronize();
        }
    }
    
    static var token: String? {
        get {
            do {
                return try keychain.get(KeychainKeys.kToken)
            } catch let error {
                Log.error(error, "Keychain get value failed!")
            }
            
            return nil
        }
        set {
            do {
                if let value = newValue {
                    try keychain.set(value, key: KeychainKeys.kToken)
                } else {
                    try keychain.remove(KeychainKeys.kToken)
                }
            } catch let error {
                Log.error(error, "Keychain set value failed!")
            }
        }
    }
}
