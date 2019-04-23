//
//  FavouritePlacesTests.swift
//  FavouritePlacesTests
//
//  Created by Kane Clerke on 8/4/19.
//  Copyright © 2019 Kane Clerke. All rights reserved.
//

import XCTest
@testable import FavouritePlaces

class FavouritePlacesTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testName() {
        let test = Places(name: "Brisbane CBD", address: "Brisbane", latitude: -125.8, longitude: 124.5)
        XCTAssert(test.name == "Brisbane CBD")
    }
    
    func testAddress() {
        let test = Places(name: "Brisbane CBD", address: "Brisbane", latitude: -125.8, longitude: 124.5)
        XCTAssert(test.address == "Brisbane")
    }
    
    func testLatitude() {
        let test = Places(name: "Brisbane CBD", address: "Brisbane", latitude: -125.8, longitude: 124.5)
        XCTAssert(test.latitude == -125.8)
    }
    
    func testLongitude() {
        let test = Places(name: "Brisbane CBD", address: "Brisbane", latitude: -125.8, longitude: 124.5)
        XCTAssert(test.longitude == 124.5)
    }
    
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
