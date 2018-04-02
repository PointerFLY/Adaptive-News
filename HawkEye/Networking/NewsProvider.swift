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

class NewsProvider {
    
    static let shared = NewsProvider()
    
    private static let kBaseURLString = "https://content.guardianapis.com/search?"
    private static let kAPIKey = "0ba0a9fa-653e-4627-af37-0b18b87009b0"
    
    private var _newsDict: [String: [News]]
    
    init() {
        _newsDict = [String: [News]]()
        let files = try! FileManager.default.contentsOfDirectory(at: URL(fileURLWithPath: NSTemporaryDirectory()), includingPropertiesForKeys: nil, options: [.skipsSubdirectoryDescendants, .skipsHiddenFiles])
        for fileURL in files {
            let fileName = fileURL.lastPathComponent
            let json = try! JSON(data: Data(contentsOf: fileURL))
            let results = json["results"].array!
            for result in results {
                let dict = result.dictionary!
                if _newsDict[fileName] == nil {
                    _newsDict[fileName] = [News]()
                }
                _newsDict[fileName]!.append(News(title: dict["webTitle"]!.string!, url: URL(string: dict["webUrl"]!.string!)!))
            }
        }
    }
    
    func getNews(tag: String) -> News {
        return _newsDict[tag]!.removeFirst()
    }
    
    func fetchAll() {
        for (tag, urn) in G.News.kTagURNs {
            let urlString = NewsProvider.kBaseURLString + urn + "&order-by=newest&page-size=100&api-key=" + NewsProvider.kAPIKey
            Alamofire.request(urlString).responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let results = json["response"]
                    let path = NSTemporaryDirectory().appending(tag)
                    try! results.rawData().write(to: URL(fileURLWithPath: path))
                case .failure(let error):
                    Log.error("Error fetch news with tag: " + tag + ", urn: " + urn + error.localizedDescription)
                    exit(EXIT_FAILURE)
                }
            }
        }
    }
}
