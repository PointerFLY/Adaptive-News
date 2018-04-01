//
//  User.swift
//  hawkEye
//
//  Created by PointerFLY on 29/03/2018.
//  Copyright © 2018 PointerFLY. All rights reserved.
//

import UIKit
import RealmSwift

class DBUser: Object {
    @objc dynamic var userName: String = ""
    @objc dynamic var password: String = ""
    @objc dynamic var gender: Int = 0
    @objc dynamic var ageGroup: Int = 0
    let tagScores = List<DBTagScore>()
    
    override static func primaryKey() -> String? {
        return "userName"
    }
}

class DBTagScore: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var score: Double = 0.0
}

