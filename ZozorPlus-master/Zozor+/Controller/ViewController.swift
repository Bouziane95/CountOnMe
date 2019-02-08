//
//  ViewController.swift
//  CountOnMe


import UIKit

class ViewController: UIViewController {
    
    //Instantiate the model
    var modelCalculate = modelCalculator()
    
   
    // MARK: - Outlets
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons : [UIButton]!
    @IBOutlet var operators: [UIButton]!
    @IBOutlet weak var point: UIButton!
    
    // MARK: - Action
    
    //Method that sends the number input in model property stringNumbers and update the display
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        for (i, numberButton) in numberButtons.enumerated() where sender == numberButton{
            modelCalculate.addNewNumber(i)
            updateDisplay()
        }
    }
    
    //Method that insert a decimal point in stringNumbers
    @IBAction func tappedPointButton(_ sender: Any){
        if modelCalculate.canAddDecimal{
            modelCalculate.addDecimal()
            updateDisplay()
        } else {
            showAlert(message: "Vous ne pouvez pas mettre 2 points")
        }
        
    }
    
    //Process the calculation by calling the calculateTotal() method from the model
    @IBAction func equal() {
        if !modelCalculate.isExpressionCorrect{
            showAlert(message: "opération invalide")
        } else {
            let total = modelCalculate.calculateTotal()
            textView.text! += "\n =\(total)"
        }
    }
    
    //Method that sends the operator input in model property operators and update the display
    @IBAction func operandButtonTapped(_ sender: UIButton){
       performOperation(operand: (sender.titleLabel?.text!)!)
    }
    
    //Resets the display and the calculator brain storage or empty
    @IBAction func allClear(_ sender: UIButton) {
        modelCalculate.allClear()
        textView.text = "0"
    }
    
    
    // MARK: - Methods
    
    //Show to the user an AlertController to explain the error
    func addNewNumber(message: String){
        let alertVC = UIAlertController(title: "Erreur", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    //Update the screen(textView) to display the numbers, operands and results
    func updateDisplay() {
        var text = ""
        // calls the existing display string
        let stack = modelCalculate.stringNumbers.enumerated()
        for (i, stringNumber) in stack {
            // Add operator
            if i > 0 {
                text += modelCalculate.operators[i]
            }
            // Add number
            text += stringNumber
        }
        // update display from stack infos
        textView.text = text
    }
    
    func showAlert(message: String){
        //instantiate the alertController
        let AlertVC = UIAlertController(title: "Erreur", message: message, preferredStyle: .alert)
        // add the cancel button
        AlertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(AlertVC,animated: true, completion: nil)
    }
    
    //Perform operation and update the display
    func performOperation(operand: String){
        if modelCalculate.canAddOperator{
            //check if we use the former result
            let result = modelCalculate.formerResult
            if result != nil {
                // round result if needed
                modelCalculate.roundResult(result)
                // display the operand on the screen and the operand in stack
                updateDisplayForResultReuse(operand: operand)
            } else {
                // send the operand in stack
                modelCalculate.sendOperand(operand: operand, number: "")
                //display the operand on the screen
                updateDisplay()}
        } else {
                self.showAlert(message: "Expression incorrecte")
            }
    }
    
    //Load again the former result when the user press an operand after a calculation
    func updateDisplayForResultReuse(operand: String){
        // reset the display to show the result
        updateDisplay()
        // store the operand in the operand stack
        modelCalculate.sendOperand(operand: operand, number: "")
        //update display to show the operand
        updateDisplay()
    }
}
