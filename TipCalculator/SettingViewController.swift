//
//  SettingViewController.swift
//  TipCalculator
//
//  Created by Kiet Nguyen on 5/29/17.
//  Copyright © 2017 Kiet Nguyen. All rights reserved.
//

import UIKit
import CoreData

class SettingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func btnClose(_ sender: Any) {
        DefaultPerCent.isLoadDataAgain = false
        dismiss(animated: true, completion: nil)
    }

    @IBAction func btn5Percent(_ sender: Any) {
        DefaultPerCent.isLoadDataAgain = true
        DefaultPerCent.defaultPercent = "5"
        //self.navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btn10Percent(_ sender: Any) {
        DefaultPerCent.isLoadDataAgain = true
        DefaultPerCent.defaultPercent = "10"
        //self.navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btn15Percent(_ sender: Any) {
        DefaultPerCent.isLoadDataAgain = true
        DefaultPerCent.defaultPercent = "15"
        //self.navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
}
