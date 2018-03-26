//
//  DetailViewController.swift
//  MoneyManger
//
//  Created by Aashish Sambharwal on 3/3/18.
//  Copyright © 2018 TeamMoney. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var personTab:TabInstance?
    var indexNum:Int?
    @IBOutlet weak var personsImage: UIImageView!
    @IBOutlet weak var navTitle: UINavigationItem!
    @IBOutlet weak var debtLentTitle: UILabel!
    @IBOutlet weak var amountExpense: UILabel!
    @IBOutlet weak var editAmount: UITextField!
    @IBOutlet weak var addSub: UISegmentedControl!
    
    func getConverted (amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: amount))!
    }
    
    func changeParentBackground() {
        amountLeft = amountLimit - (amountLent+amountOwed)
        if amountLeft < (amountLimit * 0.10) {
            self.parent?.view.backgroundColor = lightRed
        } else {
            self.parent?.view.backgroundColor = lightGreen
        }
    }
    
    @IBAction func saveChanges(_ sender: Any) {
        if let eAmount = Double(editAmount.text!) {
            if eAmount > 0 {
                let expense = eAmount  * ( (addSub.selectedSegmentIndex == 0) ? 1 : -1 )
                
                let testVal = (personTab?.getAmount())! + expense
                
                if testVal < 0 {
                    editAmount.text = ""
                    createAlert(title: "Invalid Change", message: "New amount is less than zero.")
        
                } else {
                
                    personTab?.changeAmount(expense: expense)
                    
                    amountExpense.text = "\(getConverted(amount: (personTab?.getAmount())!))"
                    
                    if (personTab?.isDebt)! {
                        amountOwed += expense
                    } else {
                        amountLent += expense
                    }
                    
                    if personTab?.getAmount() == 0 {
                        tabs.remove(at: indexNum!)
                    }
                   changeParentBackground()
                    navigationController?.popViewController(animated: true)
                }
            } else {
                editAmount.text = ""
                createAlert(title: "Invalid Amount", message: "Number has to be greater than zero.")
            }
        } else {
            editAmount.text = ""
            createAlert(title: "Illegal Number", message: "Please input a valid number for the amount section.")
        }
        
    }
    
    func createAlert (title:String, message:String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelOpt = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelOpt)
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0{
            self.view.frame.origin.y = 0
        }
    }
    @IBAction func exitAmountKeyboard(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navTitle.title = "\(personTab?.getName() ?? "N/A")'s Report"
        debtLentTitle.text = "Amount \( (personTab?.getifDebt())! ? "Owed" : "Lent" )"
        amountExpense.text = "\(getConverted(amount: (personTab?.getAmount())!))"
        
        personsImage.image = personTab?.getImage()
        
        self.view.backgroundColor = (personTab?.getifDebt())! ? lightRed : lightGreen
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
