//
//  ViewController.swift
//  TipCalculator
//
//  Created by Kiet Nguyen on 5/28/17.
//  Copyright © 2017 Kiet Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtMoneyMain: DesignTextField!
    @IBOutlet weak var txtTipMain: DesignTextField!
    @IBOutlet weak var txtPercentMain: DesignTextField!
    
    //
    var moneyInput: Double!
    var percentInput: Double!
    var tipInput: Double!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        observerKeyboard()
        addDoneButtonOnKeyboard()
        //txtTipMain.isUserInteractionEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //MARK: - Show, Hide Keyboard
    // user click return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return true
    }
    
    //user tap on screen
    @IBAction func userTapOnScreen(_ sender: Any) {
        txtPercentMain.resignFirstResponder()
        txtMoneyMain.resignFirstResponder()
    }
    
    fileprivate func observerKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: self.view.window)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: self.view.window)
    }
    
    func DismissKeyboard(){
        view.endEditing(true)
    }
    
    func keyboardWillShow(sender: NSNotification) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: -135, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
    
    func keyboardWillHide(sender: NSNotification) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
    
    //MARK - Set Done button on keyboard
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        //doneToolbar.barStyle = UIBarStyle.blackTranslucent // set style for done button bar
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(ViewController.doneButtonAction))
        
        let items = NSMutableArray()
        items.add(flexSpace)
        items.add(done)
        
        doneToolbar.items = items as? [UIBarButtonItem]
        doneToolbar.sizeToFit()
        
        self.txtMoneyMain.inputAccessoryView = doneToolbar
        self.txtPercentMain.inputAccessoryView = doneToolbar
        
    }
    
    // User click on done button
    func doneButtonAction()
    {
        view.endEditing(true)
    }
    
    //MARK: - Button Calculate
    @IBAction func btnCalculate(_ sender: Any) {
        
        if txtMoneyMain.text!.isEmpty || txtPercentMain.text!.isEmpty{
            //create alert
            let alert = UIAlertController(title: "Notification", message: "Please enter full information", preferredStyle: UIAlertControllerStyle.alert);
            //add an action
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil));
            //show alert
            self.present(alert, animated: true, completion: nil);
        } else{
            moneyInput = Double(txtMoneyMain.text!)
            percentInput = Double(txtPercentMain.text!)
            
            tipInput = (moneyInput * percentInput)/100
            txtTipMain.text = String(tipInput!)
        }
        
        
        
    }
}

