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
    
    func log(tagScores: List<DBTagScore>) {
        for tagScore in tagScores {
            currentLog += String(format: "%@-%.2f ", tagScore.name, tagScore.score)
        }
        currentLog += "\n\n"
    }
}
