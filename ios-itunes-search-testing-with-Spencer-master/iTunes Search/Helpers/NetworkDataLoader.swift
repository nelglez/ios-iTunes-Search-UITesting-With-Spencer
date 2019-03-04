//
//  NetworkDataLoader.swift
//  iTunes Search
//
//  Created by Nelson Gonzalez on 3/4/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

//Create a protocol that allows us to decide wether we want to use actual data loading (via URLSession) or mock data

protocol NetworkDataLoader {
    
    //Were not concerned with HOW the adopter of this protocol gets data back, just that it gets it back at all
    func loadData(using request: URLRequest, completion: @escaping(Data?, URLResponse?, Error?) -> Void)
}
