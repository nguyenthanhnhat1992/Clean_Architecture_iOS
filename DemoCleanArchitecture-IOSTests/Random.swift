//
//  Random.swift
//  DemoCleanArchitecture-IOSTests
//
//  Created by eru on 4/3/19.
//  Copyright © 2019 eru. All rights reserved.
//

import Foundation
import UIKit

extension Int {
    static func random() -> Int {
        return Int(arc4random())
    }
    
    static func random(in range: CountableClosedRange<Int>) -> Int {
        let diff = range.upperBound - range.lowerBound + 1
        return range.lowerBound + (Int.random() % diff)
    }
    
    static func random(in range: CountableRange<Int>) -> Int {
        let diff = range.upperBound - range.lowerBound
        return diff > 0 ? range.lowerBound + (Int.random() % diff) : range.lowerBound
    }
}

extension Double {
    public static func random(_ lower: Double = 0, _ upper: Double = 100) -> Double {
        return (Double(arc4random()) / 0xFFFFFFFF) * (upper - lower) + lower
    }
}

extension Float {
    public static func random(_ lower: Float = 0, _ upper: Float = 100) -> Float {
        return (Float(arc4random()) / 0xFFFFFFFF) * (upper - lower) + lower
    }
}

extension CGFloat {
    public static func random(_ lower: CGFloat = 0, _ upper: CGFloat = 1) -> CGFloat {
        return CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * (upper - lower) + lower
    }
}

extension String {
    enum StringType: String {
        case upper = "QWERTYUIOPASDFGHJKLZXCVBNM"
        case lower = "qwertyuiopasdfghjklzxcvbnm"
        case number = "1234567890"
    }
    
    static func random(range: CountableClosedRange<Int>, types: [StringType]) -> String {
        let characters = Array(types.reduce("") {
            $0 + $1.rawValue
        })
        let randomChar = characters.randomItems(n: Int.random(in: range))
        return String(randomChar)
    }
    
    static func random(range: CountableClosedRange<Int> = 1...10) -> String {
        return String.random(range: range, types: [.upper, .lower, .number]) + UUID().uuidString
    }
    
    public static func randomFakeName() -> String {
        return randomFakeFirstName() + " " + randomFakeLastName()
    }
    
    public static func randomFakeFirstName() -> String {
        let firstNameList = ["Henry", "William", "Geoffrey", "Jim", "Yvonne", "Jamie",
                             "Leticia", "Priscilla", "Sidney", "Nancy", "Edmund", "Bill", "Megan"]
        return firstNameList.randomItem() ?? ""
    }
    
    public static func randomFakeLastName() -> String {
        let lastNameList = ["Pearson", "Adams", "Cole", "Francis", "Andrews", "Casey", "Gross",
                            "Lane", "Thomas", "Patrick", "Strickland", "Nicolas", "Freeman"]
        return lastNameList.randomItem() ?? ""
    }
}

extension Array {
    func randomItem() -> Element? {
        return isEmpty ? nil : self[Int.random(in: 0..<count)]
    }
    
    func randomItems(n: Int) -> [Element] {
        return n <= 0 ? [] : (0..<n)
            .compactMap { _ in
                randomItem()
        }
    }
}
