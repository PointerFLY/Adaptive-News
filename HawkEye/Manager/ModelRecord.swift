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
    
    private var _textViews = [UITextView]()
    
    func register(textView: UITextView) {
        _textViews.append(textView)
    }
    
    func log(tagScores: List<DBTagScore>) {
        var log = ""
        for tagScore in tagScores {
            log += String(format: "%s: %f; ", tagScore.name, tagScore.score)
        }
        for textView in _textViews {
            textView.text.append(log)
        }
    }
}
