//
//  ViewController.swift
//  calculator
//
//  Created by Joan Coyne on 1/29/15.
//  Copyright (c) 2015 Mzinga. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   
    @IBAction func operate(sender: UIButton) {
        let operation  = sender.currentTitle!
        if userIsInTheMiddleofTypingANumber {
           enter()
        }
        switch operation {
        case "×" : performOperation{ $0 * $1 }
        case "÷" : performOperation{ $1 / $0 }
        case "+" : performOperation{ $0 + $1 }
        case "−" : performOperation{ $1 - $0 }
        case "√" : performOperation{ sqrt($0) }

            
        default: break
        }
    }
    func performOperation(operation: (Double, Double) -> Double ){
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(),  operandStack.removeLast())
            enter()
            
        }

    }
    
    func performOperation(operation: Double -> Double ){
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast())
            enter()
            
        }
        
    }
   
    @IBOutlet weak var display: UILabel!
    var userIsInTheMiddleofTypingANumber = false
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleofTypingANumber {
        display.text = display.text! + digit
        } else {
             display.text = digit
            userIsInTheMiddleofTypingANumber = true
        }
        println("digit = \(digit)")
        
    }
    
    var operandStack = Array<Double>()
    @IBAction func enter() {
        userIsInTheMiddleofTypingANumber = false
        operandStack.append(displayValue)
        println("operandStack = \(operandStack)")
        
        
    }
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
           display.text = "\(newValue)"
            userIsInTheMiddleofTypingANumber = false
        }
    }
}

