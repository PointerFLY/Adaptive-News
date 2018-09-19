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
    
    private static let kPerTagFetchCount = 10
    private static let kTotalCount = G.News.kTagURNs.count * NewsProvider.kPerTagFetchCount
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
    
    func fetchAllImageURL() {
        let realm = try! Realm()
        let dbNewsList = realm.objects(DBNews.self).filter { $0.imageURL == nil }
        
        for dbNews in dbNewsList {
            Alamofire.request(dbNews.url).responseString { response in
                let html = response.result.value!
                let doc = try! SwiftSoup.parse(html)
                let headImage = try! doc.select(".maxed.responsive-img").first()
                var imageURL = try! headImage?.attr("src");
                if imageURL == nil {
                    imageURL = "https://i.guim.co.uk/img/media/17e75f5cd9af333c75a4e2369367795811c4a2cc/0_34_4370_2622/master/4370.jpg?w=300&q=55&auto=format&usm=12&fit=max&s=78eb55a6d96eee409e0b181fb4410254"
                }
                
                try! realm.write {
                    let dbNewsList = realm.objects(DBNews.self).filter { $0.title == dbNews.title }
                    for dbNews in dbNewsList {
                        dbNews.imageURL = imageURL
                    }
                }
            }
        }
    }
    
    func fetchAllIfNeeded() -> Bool {
        let realm = try! Realm()
        let isComplete = realm.objects(DBNews.self).count == NewsProvider.kTotalCount
        let isNewest = Date().timeIntervalSince(KeyValueStore.lastNewsFetchDate) < 60 * 60
        if isComplete && isNewest { return false }
        
        KeyValueStore.lastNewsFetchDate = Date()
        try! realm.write {
            realm.delete(realm.objects(DBNews.self))
        }
        
        for (tag, urn) in G.News.kTagURNs {
            let urlString = NewsProvider.kBaseURLString + urn + "&order-by=newest&page-size=\(NewsProvider.kPerTagFetchCount)&api-key=" + NewsProvider.kAPIKey
            
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
                        
                        Alamofire.request(dbNews.url).responseString { response in
                            switch response.result {
                            case .success(let value):
                                DispatchQueue.global().async {
                                    let html = value
                                    let doc = try! SwiftSoup.parse(html)
                                    let headImage = try! doc.select(".maxed.responsive-img").first()
                                    var imageURL = try! headImage?.attr("src");
                                    if imageURL == nil {
                                        imageURL = "https://i.guim.co.uk/img/media/17e75f5cd9af333c75a4e2369367795811c4a2cc/0_34_4370_2622/master/4370.jpg?w=300&q=55&auto=format&usm=12&fit=max&s=78eb55a6d96eee409e0b181fb4410254"
                                    }
                                    dbNews.imageURL = imageURL
                                    
                                    let realm = try! Realm()
                                    try! realm.write {
                                        realm.add(dbNews)
                                    }
                                }
                                
                            case .failure(let error):
                                Log.error("Error fetch image with title: " + dbNews.title + ", urn: " + urn + error.localizedDescription)
                            }
                        }
                    }
                    
                case .failure(let error):
                    Log.error("Error fetch news with tag: " + tag + ", urn: " + urn + error.localizedDescription)
                    exit(EXIT_FAILURE)
                }
            }
        }
        
        return true
    }
}
