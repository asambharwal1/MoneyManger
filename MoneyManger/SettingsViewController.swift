//
//  SettingsViewController.swift
//  MoneyManger
//
//  Created by Aashish Sambharwal on 3/3/18.
//  Copyright © 2018 TeamMoney. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var userNameField: UITextField!
    
    @IBOutlet weak var amountLimitField: UITextField!
    
    @IBAction func updateChanges(_ sender: Any) {
        if userNameField.text != "" && amountLimitField.text != "" {
            userName = "\(self.userNameField.text!)"
            if let amt = Double(amountLimitField.text!) {
                if amt >= 0 {
                    amountLimit = amt
                
                    amountLeft = amountLimit - (amountOwed + amountLent)
                    if amountLeft < (amountLimit * 0.10) {
                        self.view.backgroundColor = lightRed
                    } else {
                        self.view.backgroundColor = lightGreen
                    }
                
                    createAlert(title: "Changes Saved", message: "Account information saved.")
                } else {
                    amountLimitField.text = ""
                    createAlert(title: "Invalid Amount", message: "Amount must be greater or equal to 0.")
                }
                
            } else {
                amountLimitField.text = ""
                createAlert(title: "Illegal Number", message: "Please input a valid number for the amount section.")
            }
        } else {
            createAlert(title: "Illegal Field", message: "One or more fields is empty.")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        amountLeft = amountLimit - (amountOwed + amountLent)
        if amountLeft < (amountLimit * 0.10) {
            self.view.backgroundColor = lightRed
        } else {
            self.view.backgroundColor = lightGreen
        }
    }
    
    func createAlert (title:String, message:String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelOpt = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelOpt)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func exitNameKeyboard(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func exitAmountKeyboard(_ sender: UITextField) {
        sender.resignFirstResponder()
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
