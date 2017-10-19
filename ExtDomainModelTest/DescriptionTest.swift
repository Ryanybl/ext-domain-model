//
//  MoneyStringTest.swift
//  ExtDomainModelTest
//
//  Created by Ryan Liang on 10/19/17.
//  Copyright © 2017 Ryan Liang. All rights reserved.
//

import XCTest
import ExtDomainModel

class DescriptionTest: XCTestCase {
    let student = Job(title: "student", type: Job.JobType.Salary(0))
    let ryan = Person(firstName: "Ryan", lastName: "Liang", age: 21)
    let spouse = Person(firstName: "someone", lastName: "Liang", age: 21)
    func testMoney () {
        let tenUSD = Money(amount: 10, currency: Money.mCurrency.USD)
        XCTAssert(String(describing: tenUSD) == "USD10")
    }
    
    func testJob() {
        XCTAssert(String(describing: student) == "student salary: 0 yearly")
    }
    
    func testPerson(){
        ryan.job = student
        XCTAssert(String(describing: ryan) == "Ryan Liang 21 years old student salary: 0 yearly")
        ryan.spouse = spouse
        XCTAssert(String(describing: ryan) == "Ryan Liang 21 years old student salary: 0 yearly with spouse someone Liang")
    }

}
