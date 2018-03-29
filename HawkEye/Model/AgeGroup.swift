//
//  AgeGroup.swift
//  hawkEye
//
//  Created by PointerFLY on 29/03/2018.
//  Copyright © 2018 PointerFLY. All rights reserved.
//

import UIKit

enum AgeGroup: Int, CustomStringConvertible {
    case kid = 0
    case teenager = 1
    case youngAdult = 2
    case middleAge = 3
    case elder = 4
    
    var description: String {
        switch self {
        case .kid: return "0 - 11"
        case .teenager: return "12 - 19"
        case .youngAdult: return "20 - 35"
        case .middleAge: return "36 - 59"
        case .elder: return ">= 60"
        }
    }
}
