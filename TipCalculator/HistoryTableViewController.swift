//
//  HistoryTableViewController.swift
//  TipCalculator
//
//  Created by Kiet Nguyen on 5/28/17.
//  Copyright © 2017 Kiet Nguyen. All rights reserved.
//

import UIKit
import CoreData

class HistoryTableViewController: UITableViewController {

    /*//get all history
    lazy var histories = [HistoryModel]()*/
    
    
    var listHistory = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "History")
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            for result in results{
                /*let moneyHis = (result as AnyObject).value(forKey: "moneyInput") as? String
                let percentHis = (result as AnyObject).value(forKey: "percentInput") as? String
                let tipHis = (result as AnyObject).value(forKey: "tipInput") as? String
                
                let historyModel: HistoryModel = HistoryModel(moneyInit: moneyHis!, percentInit: percentHis!, tipInit: tipHis!)*/
                listHistory.append(result as! NSManagedObject)
            }
        } catch {
            print("Error")
        }
        
        /*let student: Student = Student(named: textFieldName.text!, identify: textFieldID.text!, school: textFieldUni.text!, description: textViewDescript.text!, aged: String(describing: age), imaged: imgAddStudent.image!)*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listHistory.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as! HistoryTableViewCell

        let historyModel = listHistory[indexPath.row]
        
        let moneyHis = historyModel.value(forKey: "moneyInput") as? String
        let percentHis = historyModel.value(forKey: "percentInput") as? String
        let tipHis = historyModel.value(forKey: "tipInput") as? String
        
        // Configure the cell...
        cell.lblMoneyHis.text = moneyHis
        cell.lblPercentHis.text = percentHis
        cell.lblTipHis.text = tipHis

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    //MARK: - Delete History
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            // Delete the row from the data source
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            //context.delete(histories[indexPath.row])
            //histories.remove(at: indexPath.row)
            
            
            context.delete(listHistory[indexPath.row])
            listHistory.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            do {
                try context.save()
            } catch {
                fatalError("Failure to save context: \(error)")
            }
            tableView.reloadData()
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
