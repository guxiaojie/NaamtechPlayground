//
//  DetailsViewController.swift
//  NaamtechPlayground
//
//  Created by Guxiaojie on 20/03/2018.
//  Copyright © 2018 SageGu. All rights reserved.
//

import UIKit

enum Problem: Int {
    case postion = 0
    case numberReport = 1
    case calculator = 2
}

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var testCalculatorView: UIView!

    var problem = Problem.postion
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //hide tesst calculator view
        testCalculatorView.isHidden = true
        
        //set up default test case
        switch problem {
        case .postion:
            textField.text = "bcdefgabcdefg"
        case .numberReport:
            textField.text = "a_++efg"
        case .calculator:
            textField.text = "3x3+3-2";
            testCalculatorView.isHidden = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func goPlay(_ sender: Any) {
        switch problem {
        case .postion:
            //I didn't use lowercased(), looking for 'a' instead of 'A'
            resultLabel.text = position(textField.text ?? "")
        case .numberReport:
            resultLabel.text = countCharacter(textField.text ?? "")
        case .calculator:
             testCalculatorWithDefault()
        }
    }
    
    //MARK: Helper
    func covertStringToArray(_ string: String) -> Array<Character> {
        var chars:Array<Character> = []
        for c in string {
            chars.append(c)
        }
        return chars;
    }
    
    //MARK: Problem 1 find the postion of a
    func position(_ targetString: String) -> String {
        if targetString.count == 0 {
            return "N/A"
        }
        //convert string to Array<Character>
        //Array(targetString) works well, but it's a built in function
        //let characters: Array = Array(targetString)
        let characters: Array<Character> = covertStringToArray(targetString)
        //use recursion to find 'a'
        let position: Int = resursionToFindA(characters)
        //if postion = -1 means N/A
        if position > -1 {
           return "Position: \(position + 1)"
        } else {
           return "N/A"
        }
    }
    
    func resursionToFindA(_ input: Array<Character>, _ index:  Int = 0) -> Int{
        if index < input.count {
            if input[index] != "a" {
                print("search for 'a' at index: \(index)")
                return resursionToFindA(input, index + 1)
            }
            return index
        }
        return -1
    }

    //MARK: Problem 2 the report
    
    func countCharacter(_ targetString: String) -> String{
        //convert string to Array<Character>
        //Array(targetString) works well, but it's a built in function
        //var characters: Array = Array(targetString)
        var characters: Array<Character> = covertStringToArray(targetString)
        let totalCharacters = characters.count
        var output = """
            =========
            ==Report==
            """
        output += "\n"
        
        //use dictionary get count of each character, but report is not in order.
        //output += countCharacterByDictionary(characters)
        
        //use while to get count of each character
        output += countCharacterByLoop(&characters)
        
        output += "Total Characters: \(totalCharacters)"
        return output
    }
    
    func countCharacterByLoop(_ characters: inout Array<Character>) -> String {
        var output: String = ""
        //define count of each character, loop from index = 0
        var count = 0, index = 0
        while index < characters.count {
            //find same character after
            var j = index
            var characterCount = characters.count
            while j < characterCount {
                //find character!
                if characters[index] == characters[j] {
                    count += 1
                }
                //find the same one, delete it from Array
                if characters[index] == characters[j] && index != j {
                    characters.remove(at: j)
                    j -= 1
                    characterCount -= 1
                }
                j += 1
            }
            //append "character: count"; use key word SPACE/TAB instead of " "
            if characters[index] == " "{
                output += "SPACE: \(count) \n"
            } else if characters[index] == "\t"{
                output += "TAB: \(count) \n"
            } else {
                output += "\(characters[index]): \(count) \n"
            }
            
            print("character \(characters[index]): \(count)")
            //go to next character
            index += 1
            //reset the count = 0
            count = 0
        }
        return output
    }
    
    func countCharacterByDictionary(_ characters: Array<Character>) -> String{
        var output: String = ""
        var map : Dictionary <Character, Int> = Dictionary<Character, Int>()
        for character in characters {
            var count = map[character] ?? 0
            count += 1
            map[character] = count
        }
        
        for (character, count) in map {
            if character == " "{
                output += "SPACE: \(count) \n"
            } else if character == "\t"{
                output += "TAB: \(count) \n"
            } else {
                output += "\(character): \(count) \n"
            }
        }
        return output
    }
    
    //MARK: Problem 3 Calculator

    func calculator(_ string: String) -> String{
        if string.count == 0 {
            return Error.InputMissing.description
        }
        
        let infix = Infix(input: string)
        guard infix.error == nil else {
            return infix.error!.description
        }
        
        print("\n infix notation is:\(infix.expression)")
        var rpn = reversePolishNotation(expression: infix.expression)
        print("\n postfix notation is:\(rpn)")
        let result = calculate(expression: &rpn)
        print("\n result is:\(result)")
        if result is Double {
            let doubleResult = result as! Double
            return String(describing: Int(doubleResult))
        } else if result is String {
            return String(describing: result)
        }
        return Error.InputMissing.description
    }
    
    func testCalculatorWithDefault() {
        resultLabel.text = calculator(textField.text ?? "")
    }
    
    //MARK: Problem 3 - Test cases
    
    @IBAction func testCalculator(_ sender: UIButton) {
        textField.text = sender.titleLabel?.text ?? ""
        resultLabel.text = calculator(sender.titleLabel?.text ?? "")
    }
    

}
