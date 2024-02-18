//
//  TodoRequest.swift
//  TodoList
//
//  Created by Michael Chernousov on 12.02.2024.
//

import Foundation

struct TodoRequest {
    
    let session = URLSession.shared
    
    let authData: [String: Any] = [
        "login":"terev",
        "password":"1234"
    ]
    
    private let baseUrl = "http://localhost:8080/todo_list-13842842538728320721.0-SNAPSHOT/api/"
    
    func auth() async throws -> String {
        var request = URLRequest(url: URL(string: baseUrl + "user/authorization")!)
        request.httpMethod = "POST"
        request.httpBody = try JSONSerialization.data(withJSONObject: authData)
        let (data, _) = try await session.data(for: request)
        var value = String(data: data, encoding: .utf8)
        value?.removeFirst()
        value?.removeLast()
        return value ?? ""
    }
    
    func getTodo(_ token: String) async throws -> [Todo] {
        var request = URLRequest(url: URL(string: baseUrl + "todo/")!)
        request.allHTTPHeaderFields = ["Token": token]
        let (data, _) = try await session.data(for: request)
        return try JSONDecoder().decode([Todo].self, from: data)
    }
    
    func postTodo(_ todo: Todo, _ token: String) async throws {
        var request = URLRequest(url: URL(string: baseUrl + "todo/")!)
        request.allHTTPHeaderFields = ["Token": token]
        request.httpBody = try JSONEncoder().encode(todo)
        request.httpMethod = "POST"
        let _ = try await session.data(for: request)
    }
    
    func putTodo(_ todo: Todo, _ token: String) async throws {
        var request = URLRequest(url: URL(string: baseUrl + "todo/?id=\(todo.id)")!)
        request.allHTTPHeaderFields = ["Token": token]
        request.httpBody = try JSONEncoder().encode(todo)
        request.httpMethod = "PUT"
        let _ = try await session.data(for: request)
    }
    
    func deleteTodo(_ todo: Todo, _ token: String) async throws {
        var request = URLRequest(url: URL(string: baseUrl + "todo/deletion")!)
        let todoJson = try JSONEncoder().encode([ID(id: todo.id)])
        request.allHTTPHeaderFields = ["Token": token]
        request.setValue(String(data: todoJson, encoding: .utf8), forHTTPHeaderField: "Data")
        request.httpMethod = "DELETE"
        let (data, response) = try await session.data(for: request)
    }
 
    private struct ID: Codable {
        let id: Int
    }
}
