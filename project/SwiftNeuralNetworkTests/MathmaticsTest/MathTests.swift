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
    
    func testSigmoid1stDerivative() {
        XCTAssertEqual(Math.sigmoid1stDerivative(0.0), 0.25)
    }
    
    func testRandom0to1() {
        for _ in 1...5 {
            let value = Math.random0to1()
            XCTAssertGreaterThanOrEqual(value, 0.0)
            XCTAssertLessThanOrEqual(value, 1.0)
        }
    }
    
}
