//
//  UserModelManager.swift
//  HawkEye
//
//  Created by PointerFLY on 02/04/2018.
//  Copyright © 2018 PointerFLY. All rights reserved.
//

import UIKit
import RealmSwift

class UserModel {
    
    private static let kInitialTagScore = 0.25
    private static let kIncreaseFactor = 0.9
    private static let kDecreaseFactor = 1.25
    private static let kExploreRate = 0.05

    private var _dbUser: DBUser?
    private var _tagScores: List<DBTagScore> {
        return _dbUser!.tagScores
    }
    
    init(user: User) {
        _dbUser = try! Realm().object(ofType: DBUser.self, forPrimaryKey: user.userName)
    }
    
    func like(tag: String) {
        let index = _tagScores.index { $0.name == tag }!
        var score = _tagScores[index].score
        score = (pow(UserModel.kIncreaseFactor, score) - 1.0) / (UserModel.kIncreaseFactor - 1.0)
        
        try! Realm().write {
            _tagScores[index].score = score
        }
    }
    
    func dislike(tag: String) {
        let index = _tagScores.index { $0.name == tag }!
        var score = _tagScores[index].score
        if score > UserModel.kExploreRate {
            score = (pow(UserModel.kDecreaseFactor, score) - 1.0) / (UserModel.kDecreaseFactor - 1.0)
            
            try! Realm().write {
                _tagScores[index].score = score
            }
        }
    }
}

extension UserModel {
    
    static func setTagScores(dbUser: DBUser, withUser user: RegisteringUser) {
        let topicWeights = UserModel.getTopicWeights(gender: user.gender!, ageGroup: user.ageGroup!, topics: user.preferredTopics)
        dbUser.tagScores.removeAll()
        
        for (topic, tagDict) in G.News.kCategory {
            for (tag, _) in tagDict {
                let dbTagScore = DBTagScore()
                dbTagScore.name = tag
                dbTagScore.score = UserModel.kInitialTagScore * topicWeights[topic]!
                dbUser.tagScores.append(dbTagScore)
            }
        }
    }
    
    static func getTopicWeights(gender: Gender, ageGroup: AgeGroup, topics: Set<String>) -> [String: Double] {
        var weights = [String: Double]()
        G.News.kTopics.forEach { topic in
            weights[topic] = 1.0
        }
        
        switch gender {
        case .male:
            weights["Sport"] = 1.5
            weights["Sciene"] = 1.5
            weights["Technology"] = 1.5
            weights["Business"] = 1.5
        case .female:
            weights["Entertainment"] = 1.5
            weights["Life Style"] = 1.5
        case .other:
            break
        }
        
        switch ageGroup {
        case .kid:
            weights["Sport"] = 1.5
            weights["Sciene"] = 1.5
            weights["Entertainment"] = 1.5
        case .teenager:
            weights["Sport"] = 1.5
            weights["Technology"] = 1.5
            weights["Entertainment"] = 1.5
        case .youngAdult:
            weights["Technology"] = 1.5
            weights["Entertainment"] = 1.5
        case .middleAge:
            weights["Life Style"] = 1.5
            weights["Business"] = 1.5
        case .elder:
            weights["Life Style"] = 1.5
        }
        
        for topic in topics {
            weights[topic]! *= 1.5
        }
        
        return weights
    }
}
