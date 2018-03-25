//
//  Gender.swift
//  hawkEye
//
//  Created by PointerFLY on 24/03/2018.
//  Copyright © 2018 PointerFLY. All rights reserved.
//

import UIKit

enum Gender: Int, CustomStringConvertible {
    case male = 0
    case female = 1
    case other = 2
    
    var description: String {
        return ["Male", "Female", "Other"][self.rawValue]
    }
}


