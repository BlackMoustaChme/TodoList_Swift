//
//  MathOperation.swift
//  TodoList
//
//  Created by Michael Chernousov on 05.02.2024.
//

import Foundation

struct MathOperation {
    
    func sum(_ a: Double, _ b: Double) -> Double {
        return a + b
    }
    
    func substract(_ a: Double, _ b: Double) -> Double {
        return a - b
    }
    
    func divide(_ a: Double, _ b: Double) -> Double {
        return a / b
    }
    
    func multiply(_ a: Double, _ b: Double) -> Double {
        return a * b
    }
    
    func test(_ a: Double, _ b: Double, _ completion: @escaping (Double) -> Void) {
        let session = URLSession.shared
        var request = URLRequest(url: URL(string:
                                            "http://localhost:8080/calculator_back3735975708565893560/api/calc/summator?a=\(a)&b=\(b)")!)
        request.httpMethod = "POST"
        let task = session.dataTask(with: request) { data, response, error in
            print(data as Any)
            let value = data
                .flatMap { String(data: $0, encoding: .utf8) }
                .flatMap { Double($0) }
            if let value {
                DispatchQueue.main.async {
                    completion(value)
                }
            }
        }
        task.resume()
    }
    
}
