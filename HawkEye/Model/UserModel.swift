//
//  UserModel.swift
//  hawkEye
//
//  Created by PointerFLY on 26/03/2018.
//  Copyright © 2018 PointerFLY. All rights reserved.
//

import UIKit

class UserModel {
    
    static let shared = UserModel()
    
    static let kIncreaseFactor = 0.9
    static let kDecreaseFactor = 1.25
    static let kExploreRate = 0.2
    
    var superTagProbs: [String: Double]
    var tagProbs: [String: [String: Double]] {
        // calculate from scoreDic
        return scoreDic
    }
    var scoreDic: [String: [String: Double]]

    init() {
        // read the offline json model
//        scoreModel = jsonreader()
        superTagProbs = [String: Double]()
        scoreDic = [String: [String: Double]]()
    }
    
    func like(superTag: String, tag: String) {
        var score = scoreDic[superTag]![tag]!
        score = (pow(UserModel.kIncreaseFactor, score) - 1.0) / (UserModel.kIncreaseFactor - 1.0)
        scoreDic[superTag]![tag] = score
    }
    
    func dislike(superTag: String, tag: String) {
        var score = scoreDic[superTag]![tag]!
        if score > UserModel.kExploreRate {
            score = (pow(UserModel.kDecreaseFactor, score) - 1.0) / (UserModel.kDecreaseFactor - 1.0)
            scoreDic[superTag]?[tag] = score
        }
    }
    
    func syncToServer() {
        // write to json file
    }
}
