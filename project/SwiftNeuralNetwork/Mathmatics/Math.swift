//
//  Math.swift
//  SwiftNeuralNetwork
//
//  Created by Go Hayakawa on 2015/07/10.
//  Copyright (c) 2015年 Go Hayakawa. All rights reserved.
//

import Foundation

class Math {

    static func sigmoid(x: Double) -> Double {
        return 1.0 / (1.0 + exp(-x));
    }

    
    static func sigmoidDerivative(x: Double) -> Double {
        return sigmoid(x) * (1.0 - sigmoid(x))
    }

    
    static func random0to1() -> Double {
        return Double(arc4random()) / Double(UINT32_MAX)
    }
    
    
    static func mean(data: [Double]) -> Double {
        let sum = data.reduce(0.0) { $0 + $1 }
        return sum / Double(data.count)
    }
    
    
    static func standardDeviatation(data: [Double]) -> Double {
        let m = mean(data)
        let sum = data.reduce(0.0) { $0 + pow($1 - m, 2) }
        return pow(sum / Double(data.count), 0.5)
    }
   
    
    static func standardizate(data: [Double]) -> [Double] {
        let m = mean(data)
        let s = standardDeviatation(data)
        return data.map { ($0 - m) / s }
    }
}