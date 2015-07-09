//
//  Math.swift
//  SwiftNeuralNetwork
//
//  Created by Go Hayakawa on 2015/07/10.
//  Copyright (c) 2015年 Go Hayakawa. All rights reserved.
//

import Foundation

func sigmoid(x: Double) -> Double {
    return 1.0 / (1.0 + exp(-x));
}

func sigmoidFirstDerivative(x: Double) -> Double {
    return sigmoid(x) * (1.0 - sigmoid(x))
}