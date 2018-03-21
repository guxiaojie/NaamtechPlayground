

struct Stack<Element> {
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
}

enum OperatorType: CustomStringConvertible {
    case Add
    case Subtract
    case Multiply
    case Divide
    case Modulus
    
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
        }
    }
}

struct Token {
    var operand: Double
    var operatorToken: OperatorType
    
    init(operand: Double, operatorToke: OperatorType) {
        self.operand = operand
        self.operatorToken = operatorToke
    }
}

//get infix notation
public class Infix {
    var expression = [Any]()
    init(input: String?) {
        guard input != nil else {
            return
        }
        guard input!.count != 0 else {
            return
        }
        let array = Array(input!.split(separator: " "))
        for char in array {
            if Double(char) != nil {
                expression.append(Double(char)!)
            } else {
                switch char {
                case "+":
                    expression.append(OperatorToken(.Add))
                case "-":
                    expression.append(OperatorToken(.Subtract))
                case "x":
                    expression.append(OperatorToken(.Multiply))
                case "/":
                    expression.append(OperatorToken(.Divide))
                case "%":
                    expression.append(OperatorToken(.Modulus))
                default:
                    print("I don't know this token")
                }
            }
        }
    }
}

func <=(left: OperatorToken, right: OperatorToken) -> Bool {
    return left.precedence <= right.precedence
}

func <(left: OperatorToken, right: OperatorToken) -> Bool {
    return left.precedence < right.precedence
}

//shunting yard algorithm
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
    
    print(tokenStack)
    print(reversePolishNotation)
    
    return reversePolishNotation
    
}

func calculate(expression: inout [Any]) {
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
                        result = left / right
                    case .Modulus:
                        result = left.truncatingRemainder(dividingBy: right)
                    }
                    
                    //                    expression.remove(at: i - 1)
                    //                    expression.remove(at: i - 2)
                    //expression.remove(at: i)
                    let range = i-2..<i-1
                    expression.removeSubrange(range)
                    expression.insert(result, at: i - 2)
                    
                    break;
                }
                
                
            } else {
                expression.removeAll()
                break;
            }
        }
        i += 1
    }
    if expression.count >= 3 {
        calculate(expression: &expression)
    }
}