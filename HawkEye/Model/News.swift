//
//  News.swift
//  HawkEye
//
//  Created by PointerFLY on 02/04/2018.
//  Copyright © 2018 PointerFLY. All rights reserved.
//

import UIKit

class News {
    var title: String
    var tag: String
    var url: URL
    var imageURL: URL?
    
    init(dbNews: DBNews) {
        title = dbNews.title
        tag = dbNews.tag
        url = URL(string: dbNews.url)!
        if let urlString = dbNews.imageURL {
            imageURL = URL(string: urlString)
        }
    }
    
    func toDB() -> DBNews {
        let dbNews = DBNews()
        dbNews.title = title
        dbNews.tag = tag
        dbNews.url = url.absoluteString
        dbNews.imageURL = imageURL?.absoluteString
        
        return dbNews
    }
}
