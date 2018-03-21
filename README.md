# Naamtech coding test


 Xcode 9.2
 
 NaamtechPlayground  solves 3 problems.
 
 ## Architecture
 
- `ViewController.swift`:  There are 3 cells inside, Click Cell to see solution of each problem;

- `DetailsViewController.swift`:  put anything in TextFeild to test, Click "Go" to see result; There are 5 test cases in Problem 3;

- `Calculate.swift`: To solve problem 3;


## Problem 1
Given an input with a string, use recursion to find the first position letter a is on.

```objective-c
position("123asdf")
```

recursion function
```objective-c
func resursionToFindA(_ input: Array<Character>, _ index:  Int = 0) -> Int {}
```

## Problem 2
Write a program where, given a number of random string, it will output the the calculated result as a report. The equal signs used for the report title also needs to be printed out. See the example below.


```objective-c
countCharacter("bcdefgabcdefg")
```

Wrote two algorithms: countCharacterByLoop(); countCharacterByDictionary()


## Problem 3
Write a calculator which takes in a number of string input and perform calculation. The input can accept a number of operators. The operators are:
*    `+` Addition
*    `-` Subtraction
*    `x` Multiplication
*    `/` Division
*    `%` Modulus


The multiplication, division, and modulus have a higher precedence over the addition and multiplication rule. Numbers can optionally have the negative (-) sign in front of them. Decimal of all individual calculation are kept, and can only be rounded down as the total calculation. Below are sample input and output

```objective-c
 calculator("1 + 9 x 8 - 1 / 3")
```

space is must between characters

## Unit Tests
 includes a suite of unit tests within the Tests subdirectory. These tests can be run simply be executed the test action on the platform framework you would like to test.
- `NaamtechPlaygroundTests.swift`

## Additional
Run Project you will see buttons that you can click directly to test Calculator


