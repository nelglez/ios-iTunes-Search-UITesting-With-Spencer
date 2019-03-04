//
//  SearchResultControllerTests.swift
//  iTunes SearchTests
//
//  Created by Nelson Gonzalez on 3/4/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import XCTest
@testable import iTunes_Search

class SearchResultControllerTests: XCTestCase {
    
    

   //Test valid data, no error
    
    func testValidDataAndNoError() {
         let expectations = expectation(description: "Search results should not be empty")
        //Assert that searchResultControoler.searchResult.count isnt empty == false
        
        //Mimicking the URLSession dataTask and assuming that we get data and no response or error
        //2.
        let mockDataLoader = MockDataLoader(data: twitterJSON, response: nil, error: nil)
        //1.
        let searchResultController = SearchResultController(dataLoader: mockDataLoader)
        //call method we want to search
        searchResultController.performSearch(for: "Twitter", resultType: .software) {
            //2 executed
            
            XCTAssertFalse(searchResultController.searchResults.isEmpty)
            print("Fulfilling expectation")
             expectations.fulfill()
        }
        
        //1 executed
     print("Waiting for expectations(s)")
        //Ends the test. Need expectations
        waitForExpectations(timeout: 5, handler: nil)
        print("Done waiting for expecations")
       
    }
    
    //Test getting no data with an error returned
    
    func testNoDataWithErrorReturned() {
        let error = NSError(domain: "com.LambdaSchool.iTunesSearch", code: -1, userInfo: nil)
         let expectations = expectation(description: "Search results should be empty")
        
        let mockDataLoader = MockDataLoader(data: nil, response: nil, error: error)
        //1.
        let searchResultController = SearchResultController(dataLoader: mockDataLoader)
        
        searchResultController.performSearch(for: "Twitter", resultType: .software) {
             XCTAssertTrue(searchResultController.searchResults.isEmpty)
            expectations.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    //With Spencer
//    func testNoDataWithError() {
//        let error = NSError(domain: "com.LambdaSchool.iTunesSearch", code: -1, userInfo: nil)
//
//         let expectations = expectation(description: "Search results should be empty")
//
//        //This one has no data and has en error
//         let mockDataLoader = MockDataLoader(data: nil, response: nil, error: error)
//
//         let searchResultController = SearchResultController(dataLoader: mockDataLoader)
//
//        searchResultController.performSearch(for: "Twitter", resultType: .software) {
//             XCTAssertTrue(searchResultController.searchResults.isEmpty)
//            expectations.fulfill()
//        }
//         waitForExpectations(timeout: 5, handler: nil)
//    }

}
