//
//  HTTP.swift
//  Counter
//
//  Created by Andrew Copp on 12/1/17.
//  Copyright © 2017 Andrew Copp. All rights reserved.
//

import Foundation

class HTTP {
    
    let session: URLSession
    
    init() {
        let configuration: URLSessionConfiguration = URLSessionConfiguration.default
        let session: URLSession = URLSession(configuration: configuration)
        self.session = session
    }
    
    func indexCounter(completion: @escaping ([Counter]) -> ()) {
        let url: URL = URL(string: "https://ios-sample-project.herokuapp.com/counters")!
        var request: URLRequest = URLRequest(url: url)
        request.addValue("95c5355a9b86a3f38351becdff54e22c58008b25b824f556736015ee3d887b0a", forHTTPHeaderField: "Authorization")
        self.session.dataTask(with: request) { data, response, error in
            guard let data: Data = data else {
                completion([])
                return
            }
            
            let optionalJSON: [String : AnyObject]?
            do {
                optionalJSON = try JSONSerialization.jsonObject(with: data, options: []) as? [String : AnyObject]
            } catch {
                optionalJSON = [:]
            }
            
            guard let json: [String : AnyObject] = optionalJSON else {
                completion([])
                return
            }
            
            guard let counters: [[String : AnyObject]] = json["counters"] as? [[String : AnyObject]] else {
                completion([])
                return
            }
            
            completion(counters.flatMap({ Counter(json: $0)}))
        }.resume()
    }
    
}
