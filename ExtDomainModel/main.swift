//
//  main.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import Foundation

print("Hello, World!")

public func testMe() -> String {
    return "I have been tested"
}

open class TestMe {
    open func Please() -> String {
        return "I have been tested"
    }
}

////////////////////////////////////
// Money
//
public struct Money : CustomStringConvertible, Mathematics{
    
    public var amount : Int
    public var currency : mCurrency
    public var description: String{
        return "\(currency)\(amount)"
    }
    public enum mCurrency {
        case GBP
        case USD
        case EUR
        case CAN
    }
    
    public func convert(_ to: mCurrency) -> Money {
        var usd : Int;
        switch self.currency{
        case .GBP:
            usd = self.amount * 2
        case .EUR:
            usd = Int(Double(self.amount) / 3.0 * 2.0)
        case .CAN:
            usd = Int(Double(self.amount) / 5.0 * 4.0)
        case .USD:
            usd = self.amount
        }
        switch to{
        case .GBP:
            return Money(amount: Int(Double(usd) * 0.5), currency: mCurrency.GBP)
        case .EUR:
            return Money(amount: Int(Double(usd) * 1.5), currency: mCurrency.EUR)
        case .CAN:
            return Money(amount: Int(Double(usd) * 1.25), currency: mCurrency.CAN)
        case .USD:
            return Money(amount: usd, currency: mCurrency.USD)
        }
    }
    
    public func add(_ to: Money) -> Money {
        return Money(amount: self.convert(to.currency).amount + to.amount, currency: to.currency)
    }
    public func subtract(_ from: Money) -> Money {
        return Money(amount: self.convert(from.currency).amount - from.amount, currency: from.currency)
    }
}

// Mathematics protocol

protocol Mathematics {
    func add(_ to: Money) -> Money
    func subtract(_ to: Money) -> Money
}

//extend double

extension Double {
    var USD: Money{return Money(amount: Int(self), currency: Money.mCurrency.USD)}
    var EUR: Money{return Money(amount: Int(self), currency: Money.mCurrency.EUR)}
    var CAN: Money{return Money(amount: Int(self), currency: Money.mCurrency.CAN)}
    var GBP: Money{return Money(amount: Int(self), currency: Money.mCurrency.GBP)}
}

////////////////////////////////////
// Job
//
open class Job : CustomStringConvertible{
    public var description: String {
        var result = "\(title) salary: "
        switch type{
        case .Hourly(let x):
            result += "\(x) hourly"
        case .Salary(let x):
            result += "\(x) yearly"
        }
        return result
    }
    
    fileprivate var title : String
    fileprivate var type : JobType
    
    public enum JobType {
        case Hourly(Double)
        case Salary(Int)
    }
    
    public init(title : String, type : JobType) {
        self.title = title
        self.type = type
    }
    
    open func calculateIncome(_ hours: Int) -> Int {
        switch self.type{
        case .Hourly(let x):
            return Int(Double(hours) * x)
        case .Salary(let y):
            return y
        }
    }
    
    open func raise(_ amt : Double) {
        switch self.type{
        case .Hourly(let x):
            self.type = JobType.Hourly(amt + x)
        case .Salary(let y):
            self.type = JobType.Salary(Int(amt) + y)
        }
    }
}

////////////////////////////////////
// Person
//
open class Person :CustomStringConvertible{
    open var firstName : String = ""
    open var lastName : String = ""
    open var age : Int = 0
    public var description: String{
        var result = "\(firstName) \(lastName) \(age) years old"
        if(job != nil){
            result += " \(String(describing: job!))"
        }
        if(spouse != nil){
            result += " with spouse \(String(describing: spouse!.firstName)) \(String(describing: spouse!.lastName))"
        }
        return result
    }
    
    fileprivate var _job : Job? = nil
    open var job : Job? {
        get {
            return _job
        }
        set(value) {
            if age >= 16 {
                _job = value
            }
        }
    }
    
    fileprivate var _spouse : Person? = nil
    open var spouse : Person? {
        get {
            return _spouse
        }
        set(value) {
            if age >= 18 {
                _spouse = value
            }
        }
    }
    
    public init(firstName : String, lastName: String, age : Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
    
    open func toString() -> String {
        return "[Person: firstName:\(self.firstName) lastName:\(self.lastName) age:\(self.age) job:\(String(describing: self.job?.title)) spouse:\(String(describing: self.spouse?.firstName))]"
    }
}

////////////////////////////////////
// Family
//
open class Family : CustomStringConvertible{
    fileprivate var members : [Person] = []
    public var description: String{
        var result = "Family members include:"
        for member in members{
            result += String(describing: member) + " "
        }
        return result
    }
    
    public init(spouse1: Person, spouse2: Person) {
        if(spouse1.spouse == nil && spouse2.spouse == nil){
            spouse1.spouse = spouse2
            spouse2.spouse = spouse1
            members.append(spouse2)
            members.append(spouse1)
        }
    }
    
    open func haveChild(_ child: Person) -> Bool {
        for person in members {
            if(person.age >= 21){
                members.append(child)
                return true
            }
        }
        return false
    }
    
    open func householdIncome() -> Int {
        var total = 0;
        for person in members{
            if(person.job != nil){
                total += person.job!.calculateIncome(2000)
            }
        }
        return total
    }
}





