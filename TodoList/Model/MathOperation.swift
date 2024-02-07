//
//  MathOperation.swift
//  TodoList
//
//  Created by Michael Chernousov on 05.02.2024.
//

import Foundation

struct MathOperation: MathOperationProtocol{
    
    func sum(_ a: Double, _ b: Double, _ completion: @escaping (Double) -> Void) -> Double {
        return a + b
    }
    
    func substract(_ a: Double, _ b: Double, _ completion: @escaping (Double) -> Void) -> Double {
        return a - b
    }
    
    func divide(_ a: Double, _ b: Double, _ completion: @escaping (Double) -> Void) -> Double {
        return a / b
    }
    
    func multiply(_ a: Double, _ b: Double, _ completion: @escaping (Double) -> Void) -> Double {
        return a * b
    }
        
}
