//
//  MockDataLoader.swift
//  iTunes SearchTests
//
//  Created by Nelson Gonzalez on 3/4/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

@testable import iTunes_Search

class MockDataLoader: NetworkDataLoader {
    
    let data: Data?
    let response: URLResponse?
    let error: Error?
    
    init(data: Data?, response: URLResponse?, error: Error?){
       self.data = data
        self.response = response
        self.error = error
    }
    
    
    func loadData(using request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        //We dont need to use URLSession to get data instead we can get data from mockJSON file.
        
        //We want to wait 1 second before calling completion. Mimick network call taking a little time
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion(self.data, self.response, self.error)
        }
        
        
        
    }
    
}
