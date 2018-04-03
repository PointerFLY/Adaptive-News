//
//  ModelRecord.swift
//  HawkEye
//
//  Created by PointerFLY on 02/04/2018.
//  Copyright © 2018 PointerFLY. All rights reserved.
//

import UIKit
import RealmSwift

class ModelRecord {

    static let shared = ModelRecord()
    
    private(set) var currentLog = ""
    
    func log(tag: String, old: Double, new: Double) {
        currentLog += String(format: "[%@]:  Old: %.4f New: %.4f\n", tag, old, new)
    }
    
    func log(tagScores: List<DBTagScore>) {
        for tagScore in tagScores {
            currentLog += String(format: "%@:%.4f ", tagScore.name, tagScore.score)
        }
        currentLog += "\n\n"
    }
}
