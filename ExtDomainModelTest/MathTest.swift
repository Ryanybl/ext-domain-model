//
//  MathTest.swift
//  ExtDomainModelTest
//
//  Created by Ryan Liang on 10/19/17.
//  Copyright © 2017 Ryan Liang. All rights reserved.
//

import XCTest
import ExtDomainModel

class MathTest: XCTestCase {
    let tenUSD = Money(amount: 10, currency: Money.mCurrency.USD)
    let twoEUR = Money(amount: 2, currency: Money.mCurrency.EUR)
    func testAddUSDtoEUR() {
        let total = tenUSD.add(twoEUR)
        XCTAssert(total.amount == 17)
        XCTAssert(total.currency == Money.mCurrency.EUR)
    }
    
    func testSubtractUSDFromEUR(){
        let total = tenUSD.subtract(twoEUR)
        XCTAssert(total.amount == 13)
        XCTAssert(total.currency == Money.mCurrency.EUR)
    }

}
