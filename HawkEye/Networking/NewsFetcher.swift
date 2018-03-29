//
//  NewsFetcher.swift
//  hawkEye
//
//  Created by PointerFLY on 23/03/2018.
//  Copyright © 2018 PointerFLY. All rights reserved.
//

import UIKit
import Alamofire
import Yaml

class NewsFetcher {
    
    static let shared = NewsFetcher()
    
    private static let _kBaseURLString = "https://content.guardianapis.com/search?"
    private static let _kAPIKey = "0ba0a9fa-653e-4627-af37-0b18b87009b0"
    
    private init() {
        let url = Bundle.main.url(forResource: "tags", withExtension: "yml")!
        let yamlString = try! String(contentsOf: url)
        _tagsYaml = try! Yaml.load(yamlString)
    }

    private var _tagsYaml: Yaml!
    
    func fetch(params: String) {
        let urlString = NewsFetcher._kBaseURLString + params + "&order-by=newest&api-key=" + NewsFetcher._kAPIKey
        Alamofire.request(urlString).responseJSON { response in
            Log.trace(response.result.value!)
        }
    }
}
