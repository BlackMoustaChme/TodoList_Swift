//
//  ViewController.swift
//  TodoList
//
//  Created by Michael Chernousov on 02.02.2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var firstVariableTextField: UITextField!
    
    @IBOutlet weak var operationTypeSelectionButton: UIButton!
    
    @IBOutlet weak var resultButton: UIButton!
    
    @IBOutlet weak var secondVariableTextField: UITextField!
    
    @IBOutlet weak var resultTextField: UITextField!
    
    @IBOutlet weak var sumOperationCommand: UICommand!
    
    @IBOutlet weak var substractOperationCommand: UICommand!
    
    @IBOutlet weak var divideOperationCommand: UICommand!
    
    @IBOutlet weak var multiplyOperationCommand: UICommand!
    
    var firstVariable: String = ""
    
    var secondVariable: String = ""
    
    var operationType = OperationType.sum
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("Hello world!")
        firstVariableTextField.text = "0"
        secondVariableTextField.text = "0"
        resultTextField.text = "0"
        sumOperationCommand.title = "+"
        substractOperationCommand.title = "-"
        divideOperationCommand.title = "/"
        multiplyOperationCommand.title = "*"
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("Hello world!")
    }
    
    @IBAction func onFirstVariableEditingChanged(_ sender: Any) {
        firstVariable = firstVariableTextField.text ?? "0"
    }
    
    
    @IBAction func onSecondVariableEditingChanged(_ sender: Any) {
        secondVariable = secondVariableTextField.text ?? "0"
    }
    
    @IBAction func onResultButtonTouchUpInside(_ sender: Any) {
        
    }
    
}

