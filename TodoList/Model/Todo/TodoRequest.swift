//
//  TodoRequest.swift
//  TodoList
//
//  Created by Michael Chernousov on 12.02.2024.
//

import Foundation

struct TodoRequest {
    
    let authData: [String: Any] = [
        "login":"terev",
        "password":"1234"
    ]
    
    func auth(_ completion: @escaping (String) -> Void) {
        let session = URLSession.shared
        var request = URLRequest(url: URL(string:
                                            "http://localhost:8080/todo_list-13842842538728320721.0-SNAPSHOT/api/user/authorization")!)
        request.httpMethod = "POST"
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: authData)
        } catch {
            print("auth: \(error)")
        }
        let task = session.dataTask(with: request) { data, response, error in
            let value = data
                .flatMap { String(data: $0, encoding: .utf8) }
            if let value {
                DispatchQueue.main.async {
                    completion(value)
                }
            }
        }
        task.resume()
    }
    
    func getTodo(_ token: String, _ completion: @escaping ([Todo]) -> Void) {
        let session = URLSession.shared
        var request = URLRequest(url: URL(string: "http://localhost:8080/todo_list-13842842538728320721.0-SNAPSHOT/api/todo/")!)
        var _token = token
        _token.removeLast()
        _token.removeFirst()
        request.allHTTPHeaderFields = ["Token": _token]
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("getTodo_1: \(error)")
                return
            }
            do {
                if let data = data {
                    let todoArrayJson = try JSONDecoder().decode([Todo].self, from: data)
                    DispatchQueue.main.async {
                        completion(todoArrayJson)
                    }
                } else {
                    print("smth else")
                    return
                }
            } catch {
                print("getTodo_2: \(error)")
            }
        }
        task.resume()
    }
}
