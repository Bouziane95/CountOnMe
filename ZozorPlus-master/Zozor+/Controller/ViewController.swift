//
//  ViewController.swift
//  CountOnMe
//
//  Created by Ambroise COLLON on 30/08/2016.
//  Copyright © 2016 Ambroise Collon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Properties
    var CountOnMeU = viewControllerUtilities()
    
   
    // MARK: - Outlets
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons : [UIButton]!
    @IBOutlet var operators: [UIButton]!
    @IBOutlet weak var point: UIButton!
    
    // MARK: - Action
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        for (i, numberButton) in numberButtons.enumerated() where sender == numberButton{
            CountOnMeU.addNewNumber(i)
            updateDisplay()
        }
    }
    
    @IBAction func tappedPointButton(_ sender: Any){
        if CountOnMeU.canAddDecimal{
            CountOnMeU.addDecimal()
            updateDisplay()
        } else {
            showAlert(message: "Vous ne pouvez pas mettre 2 points")
        }
        
    }
    
    @IBAction func equal() {
        if !CountOnMeU.isExpressionCorrect{
            showAlert(message: "opération invalide")
        } else {
            let total = CountOnMeU.calculateTotal()
            textView.text! += "\n =\(total)"
        }
    }

    @IBAction func operandButtonTapped(_ sender: UIButton){
       performOperation(operand: (sender.titleLabel?.text!)!)
    }
    
    @IBAction func allClear(_ sender: UIButton) {
        CountOnMeU.allClear()
        textView.text = "0"
    }
    
    
    // MARK: - Methods
    func addNewNumber(message: String){
        let alertVC = UIAlertController(title: "Erreur", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func updateDisplay() {
        var text = ""
        let stack = CountOnMeU.stringNumbers.enumerated()
        for (i, stringNumber) in stack {
            // Add operator
            if i > 0 {
                text += CountOnMeU.operators[i]
            }
            // Add number
            text += stringNumber
        }
        textView.text = text
    }
    
    func showAlert(message: String){
        let AlertVC = UIAlertController(title: "Erreur", message: message, preferredStyle: .alert)
        AlertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(AlertVC,animated: true, completion: nil)
    }
    
    func performOperation(operand: String){
        if CountOnMeU.canAddOperator{
            let result = CountOnMeU.formerResult
            if result != nil {
                CountOnMeU.roundResult(result)
                updateDisplayForResultReuse(operand: operand)
            } else {
                CountOnMeU.sendOperand(operand: operand, number: "")
                updateDisplay()}
        } else {
                self.showAlert(message: "Expression incorrecte")
            }
    }
    
    func updateDisplayForResultReuse(operand: String){
        updateDisplay()
        CountOnMeU.sendOperand(operand: operand, number: "")
        updateDisplay()
    }
}
