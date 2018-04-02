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
        let dbUser = DBUser()
        dbUser.userName = userName!
        dbUser.password = (userName! + password!).md5()
        dbUser.gender = gender!.rawValue
        dbUser.ageGroup = ageGroup!.rawValue
        UserModel.setTagScores(dbUser: dbUser, withUser: self)

        return dbUser
    }
}
