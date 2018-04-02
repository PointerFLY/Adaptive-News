//
//  NewsCategory.swift
//  HawkEye
//
//  Created by PointerFLY on 01/04/2018.
//  Copyright © 2018 PointerFLY. All rights reserved.
//

import UIKit

extension G {
    struct News {
        static var kTopics: [String] = {
            let keys = kCategory.keys
            let topics = Array(keys)
            
            return topics
        }()
        
        static var kTags: [String] {
            return Array(kTagURNs.keys)
        }
        
        static var kTagURNs: [String: String] = {
            var tagURNs: [String: String]!
            for value in kCategory.values {
                tagURNs.merge(value) { (_, new) in new }
            }
            
            return tagURNs
        }()
        
        static let kCategory: [String: [String : String]] = [
            "Sport": [
                "Football": "section=football",
                "Rugby Union": "q=rugby-union&section=sport",
                "Tennis": "q=tennis&section=sport",
                "Cycling": "q=cycling&section=sport",
                "Cricket": "q=cricket&section=sport",
                "F1": "q=f1&section=sport",
                "Golf": "q=golf&section=sport",
                "US Sport": "q=us-sports&section=sport"
            ],
            "Science": [
                "Energy": "q=energy&section=science",
                "Environment": "section=environment",
                "Space": "q=space&section=science",
                "Psychology": "q=psychology",
                "Natural Science": "q=natural-science&section=science",
                "Humanities": "q=humanities",
                "Earth": "q=earth&section=science"
            ],
            "Technology": [
                "IT": "q=it&section=technology",
                "Phone": "q=phone&section=technology",
                "Robots": "q=robot&section=technology",
                "AI": "q=ai&section=technology",
                "Car": "q=car&section=technology",
                "Digital": "q=digital&section=technology"
            ],
            "Entertainment": [
                "Books": "section=books",
                "Music": "section=music",
                "TV & Radio": "section=tv-and-radio",
                "Art & Design": "section=artanddesign",
                "Film": "section=film",
                "Games": "section=games",
                "Stage": "section=stage"
            ],
            "Life Style": [
                "Fashion": "section=fashion",
                "Recipe": "q=recipe&section=lifeandstyle",
                "Food": "q=food&section=lifeandstyle",
                "Health & Fitness": "q=health|fitness&section=lifeandstyle",
                "Home & Garden": "q=home|garden&section=lifeandstyle",
                "Love & Sex": "q=love|sex&section=lifeandstyle",
                "Family": "q=family&section=lifeandstyle",
                "Money": "q=money&section=lifeandstyle",
            ],
            "Business": [
                "Trade": "q=trade&section=business",
                "Market": "q=market&section=business",
                "Company": "q=company&section=business",
                "Economy": "q=economy&section=business",
                "Stock": "q=stock&section=business",
                "Bank": "q=bank&section=business"
            ]
        ]
    }
}
