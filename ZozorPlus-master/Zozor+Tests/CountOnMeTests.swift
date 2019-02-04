//
//  Zozor_Tests.swift
//  CountOnMeTests
//
//  Created by Ambroise COLLON on 30/08/2016.
//  Copyright © 2016 Ambroise Collon. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CountOnMeTests: XCTestCase {
    var countOnMeU = viewControllerUtilities()
    
    override func setUp() {
        super.setUp()
        countOnMeU.clear()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    //Testing Utilities canAddNumber var
    func testGivenStringNumbersIsEmpty_whenAddNumber_ThenSendFalse(){
        //Set stringnumbers to empty
        countOnMeU.stringNumbers = [String()]
        XCTAssertFalse(countOnMeU.canAddOperator)
    }
    
    func testGivenStringNumbersWithEmptyString_whenAddNumber_ThenSendFalse(){
        countOnMeU.stringNumbers = [""]
        XCTAssertFalse(countOnMeU.canAddOperator)
    }
    
    func testGivenStringNumberContainsOneChar_whenAddNumber_thenSendTrue(){
        countOnMeU.stringNumbers = ["1"]
        XCTAssert(countOnMeU.canAddOperator)
    }
    
    //testing number storing
    func testGivenStackIsEmpty_whenNumberIsPressed_thenStackIsIncremented(){
        countOnMeU.addNewNumber(1)
        XCTAssert(countOnMeU.stringNumbers == ["1"])
    }
    
    func testGivenStackIsIncremented_whenNumberIsPressed_thenStackNumberAppendNewNumber(){
        countOnMeU.stringNumbers = ["10"]
        countOnMeU.addNewNumber(1)
        XCTAssert(countOnMeU.stringNumbers == ["101"])
    }
    
    //testing operand storing
    func testGivenOperatorStackIsInitial_whenOperatorButtonIsPressed_thenOperatorsStackAppendOperator(){
        countOnMeU.sendOperand(operand: "+", number: "")
        XCTAssert(countOnMeU.operators == ["+", "+"])
    }
    
    //testing if concatenation of numbers and operands are a valid operation
    func testGivenStringNumbersIsEmpty_whenFuncIsExpressionCorrectTriggered_thenSendsFalse(){
        countOnMeU.stringNumbers = [String()]
        XCTAssertFalse(countOnMeU.isExpressionCorrect)
    }
    
    func testGivenStringNumberHasOneMember_whenIsExpressionCorrectTriggered_thenSendsFalse(){
        countOnMeU.stringNumbers = ["1"]
        XCTAssert(countOnMeU.isExpressionCorrect)
    }
    
    func testGivenStringNumbersHasManyMembers_whenIsExpressionCorrectTriggered_thenSendsFalse(){
        countOnMeU.stringNumbers = ["10", "11"]
        XCTAssert(countOnMeU.isExpressionCorrect)
    }
    
    //testing calculation
    func testGivenTwoNumbers_whenEqualButtonIsPressedAndResultIsInteger_thenResultIsRounded(){
        XCTAssertFalse(countOnMeU.roundEvaluation(2.5))
        XCTAssert(countOnMeU.roundEvaluation(14.0))
    }
    
    func testGivenTwoNumbersAndOperandIsPlus_whenEqualButtonIsPressed_thenUtilitiesSendBackResult(){
        countOnMeU.stringNumbers = ["1", "2"]
        countOnMeU.operators = ["+", "+"]
        XCTAssert(countOnMeU.calculateTotal() == 3)
    }
    
    func testGivenTwoNumbersAndOperandIsMinus_whenEqualButtonIsPressed_thenUtilitiesSendBackResult(){
        countOnMeU.stringNumbers = ["10", "2"]
        countOnMeU.operators = ["+", "-"]
        XCTAssert(countOnMeU.calculateTotal() == 8)
    }
    
    func testGivenTwoNumbersAndOperandIsMultiply_whenEqualButtonIsPressed_thenUtilitiesSendBackResult(){
        countOnMeU.stringNumbers = ["10", "2"]
        countOnMeU.operators = ["+", "x"]
        XCTAssert(countOnMeU.calculateTotal() == 20)
    }
    
    func testGivenTwoNumbersAndOperandIsDivision_whenEqualButtonIsPressed_thenUtilitiesSendBackResult(){
        countOnMeU.stringNumbers = ["5", "2"]
        countOnMeU.operators = ["+", "/"]
        XCTAssert(countOnMeU.calculateTotal() == 2.5)
    }
    
    //testing AC function
    func testGivenResultIsStored_whenAcIsPressed_thenAllValuesAreCleared(){
        countOnMeU.stringNumbers = ["10", "2"]
        countOnMeU.operators = ["+", "-"]
        countOnMeU.formerResult = 8
        countOnMeU.allClear()
        XCTAssert(countOnMeU.stringNumbers == [String()])
        XCTAssert(countOnMeU.operators == ["+"])
        XCTAssert(countOnMeU.formerResult == nil)
    }
    
    //testing add decimal
    func testGivenNumberInStack_whenPointIsTapped_thenDecimalNumberIsReturned(){
        countOnMeU.stringNumbers = ["0"]
        countOnMeU.addDecimal()
        XCTAssertEqual(countOnMeU.stringNumbers, ["0."])
    }
    
    func testGivenNumberInStackIsDecimal_whenDecimalIsTapped_thenPointCannotBeAdded(){
        countOnMeU.stringNumbers = ["0.0"]
        XCTAssertFalse(countOnMeU.canAddDecimal)
    }
    
    func testGivenNumberInStackIsNotDecimal_whenDecimalIsTapped_thenPointCanBeAdded(){
        countOnMeU.stringNumbers = ["0"]
        XCTAssert(countOnMeU.canAddDecimal)
    }
    
    //testing user can use result in a new calculation
    
    func testGivenAResultIsADoubleInteger_whenResultIsSentBack_thenReturnARoundedInteger(){
        let result = 20.0
        countOnMeU.roundResult(result)
        XCTAssert(countOnMeU.stringNumbers == ["20"])
    }
    
    
    
    
    
    
    
}
