//
//  ViewControllerUtilities.swift
//  CountOnMe

import Foundation
import UIKit

//The model folder handle all the logic for the calculation

class modelCalculator: UIViewController {
    
    // MARK: - Properties
    var stringNumbers = [String()]
    var operators: [String] = ["+"]
    var formerResult: Double?
    var index = 0
    
    //Property that check if the expression is correct (only one number or empty in number stack) if so you cannot perform operation
    var isExpressionCorrect: Bool{
        if let stringNumber = stringNumbers.last{
            if stringNumber.isEmpty{
                if stringNumbers.count == 1 {
                    return false
                }
                return false
            }
        }
        return true
    }
    
    //Check if there is a number in the stack, if yes then the user can add an operand
    var canAddOperator: Bool {
        if let stringNumber = stringNumbers.last{
            if stringNumber.isEmpty && formerResult == nil{
                return false
            }
        }
        return true
    }
    
    //Checking if the stack already have a point to not add two points
    var canAddDecimal: Bool{
        if let strings = stringNumbers.last{
            if strings.contains(".") || strings.isEmpty{
                return false
            }
        }
        return true
    }
    
    //Method that append a decimal point into the number stack
    func addDecimal(){
        if let stringNumber = stringNumbers.last{
            var stringNumberDecimal = stringNumber
            //Convert int to string and append it to the former number
            stringNumberDecimal += "."
            //Replace formernumber with appended number
            stringNumbers[stringNumbers.count-1] = stringNumberDecimal
        }
    }
    
    //Perform operation between the 2 numbers in the stack
    func calculateTotal() -> Double{
        var pendingOperand: Double = 0
        var pendingOperation = ""
        var total: Double = 0
        
        //This method perform a pending operation ONLY between 2 numbers with operand + or -
        func performPendingOperation(operand: Double, operation: String, total: Double) -> Double{
            switch operation {
            case "+":
                return operand + total
            case "-":
                return operand - total
            default:
                return total
            }
        }
        for (i, stringNumber) in stringNumbers.enumerated(){
            if let  number = Double(stringNumber){
                switch operators[i]{
                case "+":
                    total = performPendingOperation(operand: pendingOperand, operation: pendingOperation, total: total)
                    pendingOperand = total
                    pendingOperation = "+"
                    total = number
                case "-":
                    total = performPendingOperation(operand: pendingOperand, operation: pendingOperation, total: total)
                    pendingOperand = total
                    pendingOperation = "-"
                    total = number
                case "/":
                    total /= number
                case "x":
                    total *= number
                default:
                    break
                }
            }
        }
        total = performPendingOperation(operand: pendingOperand, operation: pendingOperation, total: total)
        
        formerResult = total
        clear()
        return total
    }
    
    //To clear the model data
    func clear(){
        stringNumbers = [String()]
        operators = ["+"]
        index = 0
    }
    
    //To clear the model data and the former result
    func allClear(){
        clear()
        formerResult = nil
    }
    
    //When an operand is pressed this methods store the operand pressed and the first number
    func sendOperand(operand: String, number: String) {
        operators.append(operand)
        stringNumbers.append(number)
    }
    
    //add a new number in the stack and memorize the last one to calculate numbers
    func addNewNumber(_ newNumber: Int){
        if let stringNumber = stringNumbers.last{
            var stringNumberMutable = stringNumber
            //Convert int to string and append it to the former number
            stringNumberMutable += "\(newNumber)"
            //Replace former number with the number stored
            stringNumbers[stringNumbers.count-1] = stringNumberMutable
        }
    }
    
    //This method transform a double number to an int
    func roundResult(_ result: Double?){
        if roundEvaluation(result!){
            let rounded = Int(result!)
            stringNumbers = ["\(rounded)"]
            formerResult = nil
        }
    }
    
    //Check if the result is an INT
    func roundEvaluation(_ result: Double) -> Bool{
        // if a number divided by itself return 0 it is an int
        if result.truncatingRemainder(dividingBy: 1) == 0{
            return true
        }
        return false
    }
}
