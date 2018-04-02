//
//  NewsProvider.swift
//  hawkEye
//
//  Created by PointerFLY on 23/03/2018.
//  Copyright © 2018 PointerFLY. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyUserDefaults
import SwiftyJSON
import SwiftSoup
import RealmSwift

class NewsProvider {
    
    static let shared = NewsProvider()
    
    private static let kBaseURLString = "https://content.guardianapis.com/search?"
    private static let kAPIKey = "0ba0a9fa-653e-4627-af37-0b18b87009b0"
    
    private var _newsDict = [String: [News]]()
    
    func loadNews() {
        _newsDict = [String: [News]]()
        let realm = try! Realm()
        let dbNewsList = realm.objects(DBNews.self)
        for news in dbNewsList {
            if _newsDict[news.tag] == nil {
                _newsDict[news.tag] = [News]()
            }
            _newsDict[news.tag]?.append(News(dbNews: news))
        }
    }
    
    func getNews(tag: String) -> News {
        return _newsDict[tag]!.removeFirst()
    }
    
    func fetchAllIfNeeded() {
        guard (Date().timeIntervalSince(KeyValueStore.lastNewsFetchDate) >= 60 * 60) else { return }
        
        let realm = try! Realm()
        try! realm.write {
            realm.delete(realm.objects(DBNews.self))
        }
        
        for (tag, urn) in G.News.kTagURNs {
            let urlString = NewsProvider.kBaseURLString + urn + "&order-by=newest&page-size=100&api-key=" + NewsProvider.kAPIKey
            Alamofire.request(urlString).responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let results = json["response"]["results"].array!
                    for result in results {
                        let dict = result.dictionary!
                        let dbNews = DBNews()
                        dbNews.title = dict["webTitle"]!.string!
                        dbNews.url = dict["webUrl"]!.string!
                        dbNews.tag = tag
                        
                        let realm = try! Realm()
                        try! realm.write {
                            realm.add(dbNews)
                        }
                    }
                case .failure(let error):
                    Log.error("Error fetch news with tag: " + tag + ", urn: " + urn + error.localizedDescription)
                    exit(EXIT_FAILURE)
                }
            }
        }
    }
}
