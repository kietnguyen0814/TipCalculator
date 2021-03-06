//
//  CheckTableViewController.swift
//  TipCalculator
//
//  Created by Kiet Nguyen on 5/29/17.
//  Copyright © 2017 Kiet Nguyen. All rights reserved.
//

import UIKit
import CoreData

class CheckTableViewController: UITableViewController {

    var listPercent = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PercentDefault")
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            for result in results{
                /*let moneyHis = (result as AnyObject).value(forKey: "moneyInput") as? String
                 let percentHis = (result as AnyObject).value(forKey: "percentInput") as? String
                 let tipHis = (result as AnyObject).value(forKey: "tipInput") as? String
                 
                 let historyModel: HistoryModel = HistoryModel(moneyInit: moneyHis!, percentInit: percentHis!, tipInit: tipHis!)*/
                listPercent.append(result as! NSManagedObject)
            }
        } catch {
            print("Error")
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listPercent.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "check", for: indexPath)
        let percentModel = listPercent[indexPath.row]
        let perDefault = percentModel.value(forKey: "percentDefault") as? String
        // Configure the cell...
        
        cell.textLabel?.text = perDefault
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
