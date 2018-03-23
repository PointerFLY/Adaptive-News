//
//  Logger.swift
//  hawkEye
//
//  Created by PointerFLY on 23/03/2018.
//  Copyright © 2018 PointerFLY. All rights reserved.
//

import UIKit
import Log

let Log = Logger()

struct G {
    static func setup() {
        #if DEBUG
            Log.enabled = false
        #endif
    }
}

