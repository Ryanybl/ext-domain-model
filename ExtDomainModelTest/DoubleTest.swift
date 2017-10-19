//
//  DoubleTest.swift
//  ExtDomainModelTest
//
//  Created by Ryan Liang on 10/19/17.
//  Copyright © 2017 Ryan Liang. All rights reserved.
//

import XCTest

class DoubleTest: XCTestCase {
    
    func testDouble(){
        let oneUSD = 1.0.USD
        XCTAssert(oneUSD.amount == 1)
        XCTAssert(oneUSD.currency == Money.mCurrency.USD)
        let twoC = 2.0.CAN
        XCTAssert(twoC.amount == 2)
        XCTAssert(twoC.currency == Money.mCurrency.CAN)
        let threeG = 3.0.GBP
        XCTAssert(threeG.amount == 3)
        XCTAssert(threeG.currency == Money.mCurrency.GBP)
        let fourE = 4.0.EUR
        XCTAssert(fourE.amount == 4)
        XCTAssert(fourE.currency == Money.mCurrency.EUR)
    }


}
