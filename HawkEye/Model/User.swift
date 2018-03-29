//
//  User.swift
//  HawkEye
//
//  Created by PointerFLY on 29/03/2018.
//  Copyright © 2018 PointerFLY. All rights reserved.
//

import UIKit

class User {
    var userName: String
    var gender: Gender
    var ageGroup: AgeGroup
    var preferredTopics: [String]
    
    init(dbUser: DBUser) {
        userName = dbUser.userName
        gender = Gender(rawValue: dbUser.gender)!
        ageGroup = AgeGroup(rawValue: dbUser.ageGroup)!
        preferredTopics = [String]()
        dbUser.preferredTopics.forEach { item in
            preferredTopics.append(item)
        }
    }
}
