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
    
    var problem = Problem.postion
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //set up default test case
        switch problem {
        case .postion:
            textField.text = "bcdefgabcdefg"
        case .numberReport:
            textField.text = "a_++efg 在数学与计算机科学中"
        case .calculator:
            textField.text = "3 x 3 + 3 - 2";
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goPlay(_ sender: Any) {
        switch problem {
        case .postion:
            position()
        case .numberReport:
            numberOfCharacter()
        case .calculator:
            testCalculatorWithDefault()
        }
    }
    
    func covertStringToArray(_ string: String) -> Array<Character> {
        var chars:Array<Character> = []
        for c in string {
            chars.append(c)
        }
        return chars;
    }
    
    //MARK: Problem 1 find the postion of a
    func position() {
        guard let targetString = textField.text else{
            resultLabel.text = "N/A"
            return
        }
        //convert string to Array<Character>
        //I didn't use lowercased(), cause we are looking for 'a' instead of 'A'
        //Array(targetString) works well, but it's a built in function
        //let characters: Array = Array(targetString)
        let characters: Array<Character> = covertStringToArray(targetString)
        //use recursion to find 'a'
        let position: Int = resursionToFindA(characters)
        //if postion = -1 means N/A
        if position > -1 {
            resultLabel.text = "Position: \(position + 1)"
        } else {
            resultLabel.text = "N/A"
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
    
    func numberOfCharacter() {
        guard let targetString = textField.text else{
            resultLabel.text = "0"
            return
        } 
        //convert string to Array<Character>
        //Array(targetString) works well, but it's a built in function
        //let characters: Array = Array(targetString)
        var characters: Array<Character> = covertStringToArray(targetString)
        let totalCharacters = characters.count
        var output = """
            =========
            ==Report==
            """
        output += "\n"
        //define count of each character, from index = 0
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
        output += "Total Characters: \(totalCharacters)"
        resultLabel.text = output
    }
    
    func numberOfCharacterByDictionary(characters: Array<Character>) -> String{
        var output: String = ""
        var map : Dictionary <Character, Int> = Dictionary<Character, Int>()
        for character in characters {
            var count = map[character] ?? 0
            count += 1
            map[character] = count
        }
        
        for (character,count) in map {
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
    
    //MARK: Problem 3

    func calculator(_ string: String) {
        if string.count == 0 {
            resultLabel.text = Error.InputMissing.description
            return
        }
        let infix = Infix(input: string)
        guard infix.error == nil else {
            resultLabel.text = infix.error!.description
            return
        }
        print("\n infix notation is:\(infix.expression)")
        var rpn = reversePolishNotation(expression: infix.expression)
        print("\n postfix notation is:\(rpn)")
        let result = calculate(expression: &rpn)
        if result is Double {
            let doubleResult = result as! Double
            resultLabel.text = String(describing: Int(doubleResult))
        } else if result is String {
            resultLabel.text = String(describing: result)
        }
    }
    
    func testCalculatorWithDefault() {
        calculator(textField.text ?? "")
    }
    
    //MARK: Problem 3 - TEST
    
    @IBAction func testCalculator(_ sender: UIButton) {
        textField.text = sender.titleLabel?.text ?? ""
        calculator(sender.titleLabel?.text ?? "")
    }
    

}
