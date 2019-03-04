//
//  SearchResultController.swift
//  iTunes Search
//
//  Created by Spencer Curtis on 8/5/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

class SearchResultController {
    
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    var searchResults: [SearchResult] = []
    
    //This could be URLSession or something else conforming to the networkdata loader protocal
    var dataLoader: NetworkDataLoader
    
    //Most of the time we want URLSession.shared to be the data loader.
    //However, we now have the ability to pass in any other data loader if we desire.
    init(dataLoader: NetworkDataLoader = URLSession.shared) {
        self.dataLoader = dataLoader
    }
    
    
    func performSearch(for searchTerm: String, resultType: ResultType, completion: @escaping () -> Void) {
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let parameters = ["term": searchTerm,
                          "entity": resultType.rawValue]
        let queryItems = parameters.compactMap { URLQueryItem(name: $0.key, value: $0.value) }
        urlComponents?.queryItems = queryItems
        
        guard let requestURL = urlComponents?.url else { return }

        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        //Call dataloader Instead to load the data
      //  let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
        dataLoader.loadData(using: request, completion: {(data, _, error) in
        
            if let error = error { NSLog("Error fetching data: \(error)") }
            guard let data = data else { completion(); return }
            
            do {
                let jsonDecoder = JSONDecoder()
                let searchResults = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = searchResults.results
            } catch {
                print("Unable to decode data into object of type [SearchResult]: \(error)")
            }
            
            completion()
        })
      //  dataTask.resume()
    }
    
    
}
