//
//  NeuralNetworkModelTests.swift
//  NeuralNetworkModelTests
//
//  Created by Go Hayakawa on 2015/07/02.
//  Copyright (c) 2015年 Go Hayakawa. All rights reserved.
//

import UIKit
import XCTest

class NeuralNetworkModelTests: XCTestCase {
    
    var inputs: [[Double]] = []
    var targets: [[Double]] = []
    
    override func setUp() {
        super.setUp()
        
        inputs.removeAll(keepCapacity: false)
        targets.removeAll(keepCapacity: false)
        
        if let resourcePath = NSBundle(forClass: self.dynamicType).pathForResource("irisdata", ofType: "csv") {
            if let resource = String(contentsOfFile: resourcePath) {
            
                let featureSize = 4
                
                let labels = ["Iris-setosa", "Iris-versicolor", "Iris-virginica"]
                
                var lines: [String] = []
                resource.enumerateLines { (line, stop) -> () in
                    lines.append(line)
                }
       
                // Shuffle
                for i in 0..<(lines.count - 1) {
                    let j = Int(arc4random_uniform(UInt32(lines.count - i))) + i
                    swap(&lines[i], &lines[j])
                }

                var data: [[Double]] = [[Double]](count: featureSize, repeatedValue: [])

                for (index, line) in enumerate(lines) {
                    let elements = line.componentsSeparatedByString(",")
                    
                    for i in 0..<featureSize {
                        data[i].append(NSString(string: elements[i]).doubleValue)
                    }
                    
                    var target: [Double] = [0.0, 0.0, 0.0]
                    if let i = find(labels, elements[featureSize]) {
                        target[i] = 1.0
                    }
                    targets.append(target)
                }
                
                
                let standardizedData = data.map { Math.standardizate($0) }
                
                inputs = Math.transpose(standardizedData)
            
            } else {
                XCTFail("Failed to parse test data")
            }
        
        } else {
            XCTFail("Failed to load test data")
        }

    }

    
    func testPredict() {

        let model = NeuralNetworkModel(inputSize: 4, hiddenSize: 10, outputSize: 3, learningRate: 0.1)
       
        let testDataInterval = 5
      
        // Training
        for (index, input) in enumerate(inputs) {
            
            if (index % testDataInterval == 0) {
                continue
            }
            
            model.fit(input, targets: targets[index])
        }
        
        // Testing
        var totalCount = 0
        var correctCount = 0
        for (index, input) in enumerate(inputs) {
            
            if (index % testDataInterval != 0) {
                continue
            }
            
            let output = model.predict(input)
           
            println("Output: \(output)  Target: \(targets[index])")
            
            var label = 0
            var max = output[0]
            for (i, v) in enumerate(output) {
                if (v > max) {
                    label = i
                    max = v
                }
            }
            
            if (targets[index][label] > 0) {
                correctCount++
            }
            
            totalCount++
        }
        
        println("Accuracy: \(Double(correctCount) / Double(totalCount))")
    }

}
