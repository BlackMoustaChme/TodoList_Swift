//
//  MathOperationProtocol.swift
//  TodoList
//
//  Created by Michael Chernousov on 07.02.2024.
//

import Foundation

protocol MathOperationProtocol {
    
    func sum(_ a: Double, _ b: Double, _ copletion: @escaping (Double) -> Void) -> Double
    
    func substract(_ a: Double, _ b: Double, _ copletion: @escaping (Double) -> Void) -> Double
    
    func divide(_ a: Double, _ b: Double, _ copletion: @escaping (Double) -> Void) -> Double
    
    func multiply(_ a: Double, _ b: Double, _ copletion: @escaping (Double) -> Void) -> Double
    
}
