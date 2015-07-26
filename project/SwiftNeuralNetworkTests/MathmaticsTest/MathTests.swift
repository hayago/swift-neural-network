//
//  MathTests.swift
//  MathTests
//
//  Created by Go Hayakawa on 2015/07/10.
//  Copyright (c) 2015年 Go Hayakawa. All rights reserved.
//

import UIKit
import XCTest

class MathTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    
    override func tearDown() {
        super.tearDown()
    }
    
    
    func testSigmoid() {
        XCTAssertEqual(Math.sigmoid(0.0), 0.5)
    }
    
    
    func testSigmoidDerivative() {
        XCTAssertEqual(Math.sigmoidDerivative(0.0), 0.25)
    }
    
    
    func testRandom() {
        let value = Math.random(2.5, max: 3.0)
        XCTAssertGreaterThanOrEqual(value, 2.5)
        XCTAssertLessThanOrEqual(value, 3.0)
    }
    
    
    func testMean() {
        let data = [1.0, 2.0, 3.0, 4.0]
        XCTAssertEqualWithAccuracy(Math.mean(data), 2.5, 0.00001)
    }
    
    
    func testStandardDeviatation() {
        let data = [1.0, 2.0, 3.0, 4.0]
        XCTAssertEqualWithAccuracy(Math.standardDeviatation(data), 1.118, 0.001)
    }
    
    
    func testStandardization() {
        let data = [1.0, 2.0, 3.0, 4.0]
        let standardizated = Math.standardizate(data)
       
        let mean = (standardizated.reduce(0.0) { $0 + $1 }) / Double(data.count)
        XCTAssertEqualWithAccuracy(mean, 0.0, 0.0001)

        let variance = standardizated.reduce(0.0) { $0 + pow($1, 2) } / Double(data.count)
        XCTAssertEqualWithAccuracy(variance, 1.0, 0.0001)
    }
    
    
    func testTranspose() {
        let data = [[1.0, 2.0], [3.0, 4.0], [5.0, 6.0]]
        let transposedData = Math.transpose(data)
        
        XCTAssertEqual(transposedData, [[1.0, 3.0, 5.0], [2.0, 4.0, 6.0]])
    }
    
}
