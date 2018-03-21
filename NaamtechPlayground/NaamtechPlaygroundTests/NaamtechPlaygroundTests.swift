//
//  NaamtechPlaygroundTests.swift
//  NaamtechPlaygroundTests
//
//  Created by Guxiaojie on 20/03/2018.
//  Copyright © 2018 SageGu. All rights reserved.
//

import XCTest
@testable import NaamtechPlayground

class NaamtechPlaygroundTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testProblem1() {
        let viewController = DetailsViewController(nibName: "DetailsViewController", bundle: Bundle.main)
        viewController.problem = Problem.postion
        print(viewController.position("123asdf"))
    }
    
    func testProblem2() {
        let viewController = DetailsViewController(nibName: "DetailsViewController", bundle: Bundle.main)
        viewController.problem = Problem.numberReport
        print(viewController.countCharacter("123asdf"))
    }
    
    func testProblem3() {
        let viewController = DetailsViewController(nibName: "DetailsViewController", bundle: Bundle.main)
        viewController.problem = Problem.numberReport
        print(" \n ==============")
        print(viewController.calculator("1 + 9 x 8 - 1 / 3"))
        print("============== \n")
    }
}
