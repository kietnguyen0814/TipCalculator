//
//  ViewController.swift
//  TipCalculator
//
//  Created by Kiet Nguyen on 5/28/17.
//  Copyright © 2017 Kiet Nguyen. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITextFieldDelegate{

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
    
    override func viewWillAppear(_ animated: Bool) {
        if DefaultPerCent.isLoadDataAgain {
            txtPercentMain.text = DefaultPerCent.defaultPercent
        }
        txtTipMain.text = ""
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
        txtMoneyMain.resignFirstResponder()
        txtPercentMain.resignFirstResponder()
        if txtMoneyMain.text!.isEmpty || txtPercentMain.text!.isEmpty{
            //create alert
            let alert = UIAlertController(title: "Notification", message: "Please enter full information", preferredStyle: UIAlertControllerStyle.alert);
            //add an action
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil));
            //show alert
            self.present(alert, animated: true, completion: nil);
        } else if(txtMoneyMain.text! == "." || txtPercentMain.text == "."){
            let alert = UIAlertController(title: "Notification", message: "Wrong Format!!!", preferredStyle: UIAlertControllerStyle.alert);
            //add an action
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil));
            //show alert
            self.present(alert, animated: true, completion: nil);
        } else{
            
            //Calculating Tip Money
            moneyInput = Double(txtMoneyMain.text!)
            percentInput = Double(txtPercentMain.text!)
            tipInput = (moneyInput * percentInput)/100
            txtTipMain.text = String(tipInput!)
            
            //Save data to CoreData
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let newHistory = NSEntityDescription.insertNewObject(forEntityName: "History", into: context) as NSManagedObject
            newHistory.setValue(txtMoneyMain.text, forKey: "moneyInput")
            newHistory.setValue(txtPercentMain.text, forKey: "percentInput")
            newHistory.setValue(txtTipMain.text, forKey: "tipInput")
            do {
                try context.save()
            } catch {
                fatalError("Failure to save context: \(error)")
            }
        }
        
    }
    
    //MARK: - Function check input
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let inverseSet = NSCharacterSet(charactersIn:"0123456789").inverted
        
        let components = string.components(separatedBy: inverseSet)
        
        let filtered = components.joined(separator: "")
        
        if filtered == string {
            return true
        } else {
            if string == "." {
                let countdots = textField.text!.components(separatedBy:".").count - 1
                if countdots == 0 {
                    return true
                }else{
                    if countdots > 0 && string == "." {
                        return false
                    } else {
                        return true
                    }
                }
            }else{
                return false
            }
        }
    }
    
    /*@IBAction func btnCheck(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "History")
        request.returnsObjectsAsFaults = false
        
        //var results = context.execte
        do {
            let results = try context.fetch(request)
            for result in results{
                print((result as AnyObject).value(forKey: "tipInput")!)
            }
        } catch {
            print("Error")
        }
        
    }*/
    
}

