//
//  TabInstance.swift
//  MoneyManger
//
//  Created by Aashish Sambharwal on 3/3/18.
//  Copyright © 2018 TeamMoney. All rights reserved.
//

import UIKit
import Foundation

var userName = ""
var amountLimit:Double = 0
var amountLeft:Double = 0
var amountOwed:Double = 0
var amountLent:Double = 0

var lightRed = UIColor(red: 1, green: 0.4471, blue: 0.4471, alpha: 1.0)
var lightGreen = UIColor(red: 0.4471, green: 1, blue: 0.4667, alpha: 1.0)

var tabs:[TabInstance] = []

class TabInstance {
    var personName : String = ""
    var isDebt = false
    var amount = 0.0
    var userImage:UIImage = #imageLiteral(resourceName: "associate")
    
    init(name: String, debt: Bool, amount: Double, img: UIImage) {
        self.personName = name
        self.isDebt = debt
        self.amount = amount
        self.userImage = img
    }
    
    func changeAmount(expense: Double){
        amount += expense
    }
    
    func getName() -> String {
        return personName
    }
    
    func getifDebt() -> Bool {
        return isDebt
    }
    
    func getAmount() -> Double {
        return amount
    }
    
    func getImage() -> UIImage {
        return userImage
    }
}

