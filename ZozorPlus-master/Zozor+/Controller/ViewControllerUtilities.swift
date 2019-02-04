//
//  ViewControllerUtilities.swift
//  CountOnMe
//
//  Created by admin on 21/01/2019.
//  Copyright © 2019 Ambroise Collon. All rights reserved.
//

import Foundation
import UIKit

class viewControllerUtilities: UIViewController {
    var stringNumbers: [String] = [String()]
    var operators: [String] = ["+"]
    var formerResult: Double?
    var index = 0
    
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
    
    var canAddOperator: Bool {
        if let stringNumber = stringNumbers.last{
            if stringNumber.isEmpty && formerResult == nil{
                return false
            }
        }
        return true
    }
    
    var canAddDecimal: Bool{
        if let strings = stringNumbers.last{
            if strings.contains(".") || strings.isEmpty{
                return false
            }
        }
        return true
    }
    
    func addDecimal(){
        if let stringNumber = stringNumbers.last{
            var stringNumberDecimal = stringNumber
            stringNumberDecimal += "."
            stringNumbers[stringNumbers.count-1] = stringNumberDecimal
        }
    }
   
    func calculateTotal() -> Double{
        var total : Double = 0
        for (i, stringNumber) in stringNumbers.enumerated(){
            if let number = Double(stringNumber){
                switch operators[i]{
                case "+":
                    total += number
                case "-":
                    total -= number
                case "x":
                    total *= number
                case "/":
                    total /= number
                default:
                    break
                }
            }
        }
        formerResult = total
        clear()
        return total
        
    }
    
    func clear(){
        stringNumbers = [String()]
        operators = ["+"]
        index = 0
    }
    
    func allClear(){
        clear()
        formerResult = nil
    }
    
    func sendOperand(operand: String, number: String) {
        operators.append(operand)
        stringNumbers.append(number)
    }
    func addNewNumber(_ newNumber: Int){
        if let stringNumber = stringNumbers.last{
            var stringNumberMutable = stringNumber
            stringNumberMutable += "\(newNumber)"
            stringNumbers[stringNumbers.count-1] = stringNumberMutable
        }
    }
    
    func roundResult(_ result: Double?){
        if roundEvaluation(result!){
            let rounded = Int(result!)
            stringNumbers = ["\(rounded)"]
            formerResult = nil
        }
    }
    
    func roundEvaluation(_ result: Double) -> Bool{
        if result.truncatingRemainder(dividingBy: 1) == 0{
            return true
        }
        return false
    }
}
