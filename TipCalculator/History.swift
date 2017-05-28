	//
//  History.swift
//  TipCalculator
//
//  Created by Kiet Nguyen on 5/28/17.
//  Copyright © 2017 Kiet Nguyen. All rights reserved.
//

    //Not Use
import Foundation

class HistoryModel: NSObject {
    
        var money: String
        var percent: String
        var tip: String
        
        init(moneyInit: String, percentInit: String, tipInit: String) {
            self.money = moneyInit
            self.percent = percentInit
            self.tip = tipInit
        }
}
