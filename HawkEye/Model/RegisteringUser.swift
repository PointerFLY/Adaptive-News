//
//  RegisteringUser.swift
//  hawkEye
//
//  Created by PointerFLY on 29/03/2018.
//  Copyright © 2018 PointerFLY. All rights reserved.
//

import UIKit
import RealmSwift
import CryptoSwift

class RegisteringUser {
    var userName: String?
    var password: String?
    var gender: Gender?
    var ageGroup: AgeGroup?
    var preferredTopics = Set<String>()
    
    func toDB() -> DBUser {
        let user = DBUser()
        user.userName = userName!
        user.password = password!.md5()
        user.gender = gender!.rawValue
        user.ageGroup = ageGroup!.rawValue
        // TODO: Write UserModel
        
        return user
    }
}
