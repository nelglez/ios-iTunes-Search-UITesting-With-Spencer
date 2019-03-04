//
//  URLSession+NetworkDataLoader.swift
//  iTunes Search
//
//  Created by Nelson Gonzalez on 3/4/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

//We dont have the source code for URLSession, but we can extend its functionality

extension URLSession: NetworkDataLoader {
    //This is how we want to load data when we are using URLsession.
    func loadData(using request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
      //  dataTask(with: request, completionHandler: completion).resume()//Instead of below we can do this
        
        //Create data task. We have all the info we need from this request.
        dataTask(with: request) { (data, response, error) in
            // We don't care about the data, response, and error here. We want to keep this generic, so we will "forward" those things to whatever is calling `loadData` in the first place
            completion(data, response, error)
        }.resume()
    }
}
