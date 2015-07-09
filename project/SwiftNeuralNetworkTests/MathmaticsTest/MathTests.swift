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
        XCTAssertEqual(sigmoid(0.0), 0.5)
    }
    
    func testSigmoidFirstDerivative() {
        XCTAssertEqual(sigmoidFirstDerivative(0.0), 0.25)
    }
    
}
