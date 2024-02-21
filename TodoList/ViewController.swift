//
//  ViewController.swift
//  TodoList
//
//  Created by Michael Chernousov on 02.02.2024.
//

import UIKit

import SwiftUI

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var addButton: UIButton!
    
    private let dataSource = DataSource()
    
    private let delegate = Delegate()
    
    let todoRequest = TodoRequest()
    
    let userDefaults = UserDefaults.standard
    
    var token: String? //{
//        get {
//            userDefaults.string(forKey: "token")
//        }
//        set {
//            userDefaults.setValue(newValue, forKey: "token")
//        }
    //}
    
    override func viewDidLoad() {
        super.viewDidLoad()
//         Do any additional setup after loading the view.
        addButton.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        tableView.dataSource = dataSource
        tableView.delegate = delegate
        delegate.parent = self
        dataSource.parent = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        Task { await requestTodos() }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("Hello world!")
    }
    
    private func requestToken() async throws -> String {
        if let token {
            return token
        }
        let newToken = try await todoRequest.auth()
        token = newToken
        return newToken
    }
    
    private func requestTodos() async {
        do {
            let token = try await requestToken()
            dataSource.todos = try await todoRequest.getTodo(token)
            tableView.reloadData()
        } catch {
            print(error)
        }
    }
    
    private func addTodo(_ todo: Todo) async {
        do {
            let token = try await requestToken()
            try await todoRequest.postTodo(todo, token)
            await requestTodos()
        } catch {
            print(error)
        }
    }
    
    private func updateTodo(_ todo: Todo) async {
        do {
            let token = try await requestToken()
            try await todoRequest.putTodo(todo, token)
            await requestTodos()
        } catch {
            print(error)
        }
    }
    
    private func deleteTodo(_ todo: Todo) async {
        do {
            let token = try await requestToken()
            try await todoRequest.deleteTodo(todo, token)
            await requestTodos()
        } catch {
            print(error)
        }
    }
    
    private func didSelectRow(at indexPath: IndexPath) {
        let todo = dataSource.todos[indexPath.row]
        print(todo)
        let controller = UIHostingController(rootView: SwiftUIView(todo: todo, onSave: { [weak self] todo in
            print(todo)
            Task { await self?.updateTodo(todo) }
        }))
        present(controller, animated: true)
    }
    
    private func trailingSwipeActionsConfigurationForRow(at indexPath: IndexPath) {
        let todo = dataSource.todos[indexPath.row]
        Task { await deleteTodo(todo) }
    }
    
    private func onCheckButton(at indexPath: IndexPath) {
        var todo = dataSource.todos[indexPath.row]
        todo.check.toggle()
        Task { await updateTodo(todo) }
    }
    
    
    @IBAction func onAddButton(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
        let currentDate = dateFormatter.string(from: Date.now)
        let todo = Todo(id: 0, title: "", creationDate: currentDate, text: "", check: false)
        print(todo)
        let controller = UIHostingController(rootView: SwiftUIView(todo: todo, onSave: { [weak self] todo in
            print(todo)
            Task {await self?.addTodo(todo)}
        }))
        present(controller, animated: true)
    }
    
}

private extension ViewController {
    final class DataSource: NSObject, UITableViewDataSource {
        
        weak var parent: ViewController?
        
        let todoRequest = TodoRequest()
        
        var todos: [Todo] = []
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return todos.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
            let todo = todos[indexPath.row]
            cell.titleTextLabel.text = todo.title
            cell.dateTextLabel.text = todo.creationDate
            cell.descriptionTextLabel.text = todo.text
            if todo.check {
                cell.checkButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
            } else {
                cell.checkButton.setImage(UIImage(systemName: "square"), for: .normal)
            }
            cell.onCheck = { [weak self] in
                self?.parent?.onCheckButton(at: indexPath)
            }
            return cell
        }
        
    }
    
    final class Delegate: NSObject, UITableViewDelegate {
        
        weak var parent: ViewController?
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            parent?.didSelectRow(at: indexPath)
        }
        
        func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, handler) in
                self?.parent?.trailingSwipeActionsConfigurationForRow(at: indexPath)
                handler(true)
            }
            deleteAction.backgroundColor = .red
            let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
            configuration.performsFirstActionWithFullSwipe = false
            return configuration
        }
    }
}

