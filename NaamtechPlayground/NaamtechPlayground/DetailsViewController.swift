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
            textField.text = "a++e+fg"
        case .calculator:
            textField.text = "2 x 3 + 2 + 5 + 7 - 55 - 0 - 12 - 4 / 17 / 3 x 7 + 2 - 16"
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
    
    //MARK: Problem 1 find the postion of a
    func position() {
        guard let targetString = textField.text else{
            resultLabel.text = "N/A"
            return
        }
        //convert string to Array<Character>
        //I didn't use lowercased(), cause we are looking for 'a' instead of 'A'
        let characters: Array = Array(targetString)
        //flag postion
        var position: Int = 0
        //use recursion to find 'a'
        resursionToFindA(characters, &position)
        //if postion = -1 means N/A
        if position > -1 {
            resultLabel.text = "Position: \(position + 1)"
        } else {
            resultLabel.text = "N/A"
        }
    }
    
    func resursionToFindA(_ input: Array<Character>, _ index: inout Int){
        if index < input.count && index >= 0 {
            print("search for 'a' at index: \(index)")
            if input[index] != "a" {
                index += 1
                resursionToFindA(input, &index)
            } else {
                //stop resursion by using Int.max
                var stopResursion = Int.max
                resursionToFindA(input, &stopResursion)
            }
        } else {
            //show N/A by using -1
            index = -1
        }
    }

    //MARK: Problem 2
    
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

    }
}
