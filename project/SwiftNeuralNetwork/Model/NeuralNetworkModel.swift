//
//  NeuralNetworkModel.swift
//  SwiftNeuralNetwork
//
//  Created by Go Hayakawa on 2015/07/05.
//  Copyright (c) 2015年 Go Hayakawa. All rights reserved.
//

import Foundation

public class NeuralNetworkModel {
   
    // Unit Size
    private let inputSize: Int
    private let hiddenSize: Int
    private let outputSize: Int
    
    // Learning Rate
    private let learningRate: Double
    
    // Weights
    private var firstWeights: [[Double]]
    private var secondWeights: [[Double]]

    // Biases
    private var hiddenBiases: [Double]
    private var outputBiases: [Double]
    
    // Activate Function
    private let activateFunction: (Double) -> Double
    private let activateFunction1stDerivative: (Double) -> Double
   
    
    public init(inputSize: Int, hiddenSize: Int, outputSize: Int, learningRate: Double = 0.1) {
        self.inputSize = inputSize
        self.hiddenSize = hiddenSize
        self.outputSize = outputSize
        
        self.learningRate = learningRate
        
        // Initialize first wieghts
        firstWeights = []
        for _ in 1...inputSize {
            var w = [Double]()
            for _ in 1...hiddenSize { w.append(Math.random0to1()) }
            firstWeights.append(w)
        }

        // Initialize second wieghts
        secondWeights = []
        for _ in 1...hiddenSize {
            var w = [Double]()
            for _ in 1...outputSize { w.append(Math.random0to1()) }
            secondWeights.append(w)
        }

        // Initialize biases
        hiddenBiases = [Double](count: hiddenSize, repeatedValue: 0)
        outputBiases = [Double](count: outputSize, repeatedValue: 0)
       
        // Set activate function
        activateFunction = Math.sigmoid
        activateFunction1stDerivative = Math.sigmoid1stDerivative
    }
    
    
    public func feedForward(inputs: [Double]) -> (hiddens: [Double], outputs: [Double]) {
        // Calcurate hidden unit values
        var hiddens: [Double] = []
        for j in 0..<hiddenSize {
            var sum: Double = hiddenBiases[j]
            for i in 0..<inputSize {
                sum += (firstWeights[i][j] * inputs[i])
            }
            hiddens.append(activateFunction(sum))
        }
    
        // Calcurate output unit values
        var outputs: [Double] = []
        for k in 0..<outputSize {
            var sum: Double = outputBiases[k]
            for j in 0..<hiddenSize {
                sum += (secondWeights[j][k] * hiddens[j])
            }
            outputs.append(sum)
        }
        
        return (hiddens: hiddens, outputs: outputs)
    }
    
    
    public func fit(inputs: [Double], targets: [Double]) {
        // Calcurate unit values
        let result = feedForward(inputs)
        let outputs = result.outputs
        let hiddens = result.hiddens
        
        //// Back Propagation ////
        
        // Update second weights
        for k in 0..<outputSize {
            let delta = result.outputs[k] - targets[k]
            
            for j in 0..<hiddenSize {
                let gradient = delta * hiddens[j]
                
                // Gradient Descent Optimization
                secondWeights[j][k] -= (learningRate * gradient)
            }
            
            // Update output biases
            let gradient = delta * 1.0
            outputBiases[k] -= (learningRate * gradient)
        }
        
        // Update first weights
        for j in 0..<hiddenSize {
            var delta: Double = 0.0
            
            for k in 0..<outputSize {
                delta += secondWeights[j][k] * (result.outputs[k] - targets[k])
            }
            delta *= (1 - pow(hiddens[j], 2))
            
            for i in 0..<inputSize {
                let gradient = delta * inputs[i]
                
                firstWeights[i][j] -= (learningRate * gradient)
            }
            
            let gradient = delta * 1.0
            hiddenBiases[j] -= (learningRate * gradient)
        }
    }

}
