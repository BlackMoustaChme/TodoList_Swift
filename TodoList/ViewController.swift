//
//  ViewController.swift
//  TodoList
//
//  Created by Michael Chernousov on 02.02.2024.
//

import UIKit

import SwiftUI

class ViewController: UIViewController {

    @IBOutlet weak var firstVariableTextLabel: UILabel!
    
    @IBOutlet weak var secondVariableTextLabel: UILabel!
    
    @IBOutlet weak var firstVariableTextField: UITextField!
    
    @IBOutlet weak var secondVariableTextField: UITextField!
    
    @IBOutlet weak var operationTypeTextLabel: UILabel!
    
    @IBOutlet weak var operationTypeTextField: UITextField!
    
    @IBOutlet weak var resultButton: UIButton!

    @IBOutlet weak var resultTextLabel: UILabel!
    
    @IBOutlet weak var resultTextField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    var firstVariable: String = ""
    
    var secondVariable: String = ""
    
    var operationType = OperationType.sum
    
    let mathOperation: MathOperationProtocol = HttpMathOperation()
    
    private let dataSource = DataSource()
    
    private let delegate = Delegate()
    
    let todoRequest = TodoRequest()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//         Do any additional setup after loading the view.
        firstVariableTextLabel.text = "First Variable"
        secondVariableTextLabel.text = "Second Variable"
        operationTypeTextLabel.text = "Operation Type (+, -, /, *)"
        resultTextLabel.text = "Result"
        resultTextField.text = "0"
        tableView.dataSource = dataSource
        tableView.delegate = delegate
        delegate.parent = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        todoRequest.auth { [weak self, dataSource] value in
            self?.todoRequest.getTodo(value) { value in
                dataSource.todos = value
                self?.tableView.reloadData()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("Hello world!")
    }
    
    private func didSelectRow(at indexPath: IndexPath) {
        let todo = dataSource.todos[indexPath.row]
        print(todo)
    }
    
    @IBAction func onFirstVariableEditingChanged(_ sender: Any) {
        firstVariable = firstVariableTextField.text ?? "0"
    }
    @IBAction func onSecondVariableEditingChanged(_ sender: Any) {
        secondVariable = secondVariableTextField.text ?? "0"
    }
    
    @IBAction func onEditingDidEnd(_ sender: Any) {
        operationType = operationTypeTextField.text.flatMap { OperationType(rawValue: $0) } ?? .sum
    }
    
    @IBAction func onResultButtonTouchUpInside(_ sender: Any) {
        var a: Double = Double(firstVariable) ?? 0
        var b: Double = Double(secondVariable) ?? 0
        switch operationType {
        case .sum:
//            resultTextField.text = String(mathOperation.sum(a, b))
            mathOperation.sum(a, b) { [weak self] value in
                let result = String(value)
                self?.resultTextField.text = result
            }
        case .substract:
//            resultTextField.text = String(mathOperation.substract(a, b))
            mathOperation.substract(a, b) { [weak self] value in
                let result = String(value)
                self?.resultTextField.text = result
            }
        case .divide:
//            resultTextField.text = String(mathOperation.divide(a, b))
            mathOperation.divide(a, b) { [weak self] value in
                let result = String(value)
                self?.resultTextField.text = result
            }
        case .multiply:
//            resultTextField.text = String(mathOperation.multiply(a, b))
            mathOperation.multiply(a, b) { [weak self] value in
                let result = String(value)
                self?.resultTextField.text = result
            }
        }
    }
    
    @IBAction func onButton(_ sender: Any) {
        let controller = UIHostingController(rootView: SwiftUIView())
        present(controller, animated: true)
    }
    
}

private extension ViewController {
    final class DataSource: NSObject, UITableViewDataSource {
        
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
            return cell
        }
    }
    
    final class Delegate: NSObject, UITableViewDelegate {
        weak var parent: ViewController?
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            parent?.didSelectRow(at: indexPath)
        }
    }
}

