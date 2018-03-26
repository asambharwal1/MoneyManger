//
//  TabsViewController.swift
//  MoneyManger
//
//  Created by Aashish Sambharwal on 3/3/18.
//  Copyright © 2018 TeamMoney. All rights reserved.
//

import UIKit

class TabsViewController: UITableViewController {

    @IBOutlet weak var addDebtLent: UIBarButtonItem!
    @IBOutlet var uitable: UITableView!
    
    func getConverted (amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: amount))!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addDebtLent.isEnabled = false
        addDebtLent.isEnabled = true
        uitable.reloadData()
        if amountLeft < (amountLimit * 0.10) {
            self.view.backgroundColor = lightRed
        } else {
            self.view.backgroundColor = lightGreen
        }
    }
    
    func updateBackgroundColor () {
        amountLeft = amountLimit - (amountOwed + amountLent)
        if amountLeft < (amountLimit * 0.10) {
            self.view.backgroundColor = lightRed
        } else {
            self.view.backgroundColor = lightGreen
        }
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
        return tabs.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath)
        let tabIns = tabs[indexPath.row]
        cell.textLabel?.text = "\(tabIns.getName())"
        cell.detailTextLabel?.text = "Amount \( (tabIns.getifDebt() ? "Owed" : "Lent" ) ): \(getConverted(amount: tabIns.getAmount()))"
        
        let colorText = (tabIns.getifDebt()) ? lightRed : lightGreen
        
        /*cell.textLabel?.textColor = colorText
        cell.detailTextLabel?.textColor = colorText
        */
        cell.backgroundColor = colorText
        cell.imageView?.image = tabIns.getImage()
        // Configure the cell...

        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let tabsDL = tabs[indexPath.row]
            if tabsDL.getifDebt() {
                amountOwed -= tabsDL.getAmount()
            } else {
                amountLent -= tabsDL.getAmount()
            }
            tabs.remove(at: indexPath.row)
            
            updateBackgroundColor()
            
            
            tableView.reloadData()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        guard let detailViewController = segue.destination as? DetailViewController else { return }
        guard let cell = sender as? UITableViewCell else { return }
        guard let indexPath = self.tableView.indexPath(for: cell) else { return }
        detailViewController.personTab = tabs[indexPath.row]
        detailViewController.indexNum = indexPath.row
    }
    

}
