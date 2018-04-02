//
//  DBNews.swift
//  HawkEye
//
//  Created by PointerFLY on 02/04/2018.
//  Copyright © 2018 PointerFLY. All rights reserved.
//

import UIKit
import RealmSwift

class DBNews: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var tag: String = ""
    @objc dynamic var url: String = ""
    @objc dynamic var imageURL: String?
}
