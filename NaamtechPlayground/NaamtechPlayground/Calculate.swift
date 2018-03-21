
// Stack
struct Stack<Element> {
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
}

// Error
enum Error: CustomStringConvertible {
    case DivZero
    case InputMissing
    case Syntax
    
    var description: String {
        switch self {
        case .DivZero:
            return "Error: Division by zero"
        case .Syntax:
            return "Error: Syntax Error"
        case .InputMissing:
            return "Error: Function input missing"
        }
    }
}

// OperatorType
enum OperatorType: CustomStringConvertible {
    case Add
    case Subtract
    case Multiply
    case Divide
    case Modulus
    case Space
    case Unsupport
    
    var description: String {
        switch self {
        case .Add:
            return "+"
        case .Subtract:
            return "-"
        case .Multiply:
            return "*"
        case .Divide:
            return "/"
        case .Modulus:
            return "%"
        case .Space:
            return " "
        case .Unsupport:
            return ""
        }
    }
}

struct OperatorToken {
    let operatorType: OperatorType
    
    init(_ operatorType: OperatorType) {
        self.operatorType = operatorType
    }
    
    var precedence: Int {
        switch operatorType {
        case .Add, .Subtract:
            return 0
        case .Divide, .Multiply, .Modulus:
            return 5
        default:
            return 0
        }
    }
}

func parseOperator(_ input : Character) -> OperatorType {
    switch input {
    case "+":
        return .Add
    case "-":
        return .Subtract
    case "x":
        return .Multiply
    case "/":
        return .Divide
    case "%":
        return .Modulus
    case " ":
        return .Space
    default:
        return .Unsupport
    }
}

// Infix notation
public class Infix {
    var expression = [Any]()
    var error: Error?
    init(input: String?) {
        guard input != nil else {
            return
        }
        guard input!.count != 0 else {
            return
        }
        
        //built in function .split(separator: " ")
        //let array = Array(input!.split(separator: " "))
        let array = parse(input!)
        guard array != nil else {
            return
        }
        expression = array!
    }
    
    func parse(_ input : String) -> Array<Any>? {
        var characters : Array<Any> = []
        var lastNumberCharacter : String = ""
        let newInput = input + " "
        var lastIsOperator = false
        var isNegative = false
        for character in newInput {
            //get numbers
            if (character >= "0" && character <= "9") {
                lastNumberCharacter += String(character)
                continue
            }
            if lastNumberCharacter != "" {
                let value = Double(lastNumberCharacter)
                if (value != nil) {
                    characters.append(value! * (isNegative ? -1:1))
                    lastIsOperator = false
                    isNegative = false
                } else {
                    return nil
                }
            }
            
            // Get operation type from string
            let op = parseOperator(character)
            if op == .Unsupport {
                return nil
            }
            
            // Rest lastNumberCharacter
            lastNumberCharacter = ""
            
            // Check if there is no Space
            if op != .Space {
                if lastIsOperator {
                    // Check if this is a negative
                    if character == "-" {
                        isNegative = true
                        continue
                    } else {
                        return nil
                    }
                }
                lastIsOperator = true
                characters.append(OperatorToken(op))
            }
        }
        return characters;
    }
}

func <=(left: OperatorToken, right: OperatorToken) -> Bool {
    return left.precedence <= right.precedence
}

func <(left: OperatorToken, right: OperatorToken) -> Bool {
    return left.precedence < right.precedence
}

// Shunting yard algorithm
public func reversePolishNotation(expression: [Any]) -> [Any] {
    //push Operators to tokenStack
    var tokenStack = Stack<OperatorToken>()
    //array RPN(Reverse Polish Notation) is postfix notation
    var reversePolishNotation = [Any]()
    
    for token in expression {
        if token is Double {
            reversePolishNotation.append(token)
        } else if token is OperatorToken {
            
            for tempToken in tokenStack.items {
                let operatorToke: OperatorToken = token as! OperatorToken
                
                if operatorToke <= tempToken {
                    reversePolishNotation.append(tokenStack.pop())
                }
            }
            
            tokenStack.push(token as! OperatorToken)
        }
    }
    
    while tokenStack.items.count > 0 {
        reversePolishNotation.append(tokenStack.pop())
    }
    return reversePolishNotation
    
}


func calculate(expression: inout [Any]) -> Any{
    var i = 0
    var result: Double = 0
    while i < expression.count {
        let token = expression[i]
        
        if token is OperatorToken {
            if i - 2 < expression.count && i - 2 >= 0{
                if let left = expression[i - 2] as? Double, let right = expression[i - 1] as? Double{
                    
                    let operatorToke: OperatorToken = token as! OperatorToken
                    switch operatorToke.operatorType {
                    case .Add:
                        result = left + right
                    case .Subtract:
                        result = left - right
                    case .Multiply:
                        result = left * right
                    case .Divide:
                        if right == 0 {
                            return Error.DivZero.description
                        } else {
                            result = left / right
                        }
                    case .Modulus:
                        result = left.truncatingRemainder(dividingBy: right)
                    default:
                        return Error.Syntax.description
                    }
                    
                    //not sure if I can use removeSubrange, otherwise remove 3 times.
//                    expression.remove(at: i - 2)
//                    expression.remove(at: i - 2)
//                    expression.remove(at: i - 2)
                    let range = i-2..<i+1
                    expression.removeSubrange(range)
                    
                    //finishing calculating all operators
                    if expression.count == 0 {
                        return result
                    } else {
                        expression.insert(result, at: i - 2)
                        return calculate(expression: &expression)
                    }
                }
            } else {
                var a = [Any]()
                return calculate(expression: &a)
            }
        }
        i += 1
    }
    return Error.Syntax.description
}
