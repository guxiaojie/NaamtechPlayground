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
            textField.text = "1 x 2 + 3 - 4";//2 x 3 + 2 + 5 + 7 - 55 - 0 - 12 - 4 / 17 / 3 x 7 + 2 - 16"
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
            calculator()
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
        let characters:Array<Character> = covertStringToArray(targetString)
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
        var characters: Array = Array(targetString)
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
                //find a same one, delete it from Array
                if characters[index] == characters[j] && index != j {
                    characters.remove(at: j)
                    j -= 1
                    characterCount -= 1
                }
                j += 1
            }
            //append number of each character
            //use key word SPACE/TAB instead of " "
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
    
    //MARK: Problem 3

    func calculator() {
        guard let targetString = textField.text else{
            resultLabel.text = "N/A"
            return
        }
        let infix = Infix(input: targetString)
        print("\n infix notation is:\(infix.expression)")
        var rpn = reversePolishNotation(expression: infix.expression)
        print("\n postfix notation is:\(rpn)")
        let result = calculate(expression: &rpn)
        resultLabel.text = String(describing: result)
    }
}
