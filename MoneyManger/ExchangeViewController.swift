//
//  ExchangeViewController.swift
//  MoneyManger
//
//  Created by Aashish Sambharwal on 3/3/18.
//  Copyright © 2018 TeamMoney. All rights reserved.
//

import UIKit

class ExchangeViewController: UIViewController {

    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var personName: UITextField!
    @IBOutlet weak var isDebtOrLent: UISegmentedControl!
    @IBOutlet weak var amountExchange: UITextField!
    
    
    @IBAction func changeType(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.view.backgroundColor = lightRed
        } else {
            self.view.backgroundColor = lightGreen
        }
    }
    
    @IBAction func changeImage(_ sender: UISegmentedControl) {
        
        switch (sender.selectedSegmentIndex) {
        case 0:
            personImage.image = #imageLiteral(resourceName: "associate")
            break
        case 1:
            personImage.image = #imageLiteral(resourceName: "friends")
            break
        case 2:
            personImage.image = #imageLiteral(resourceName: "family")
            break
        default:
            break;
        }
        
    }
    @IBAction func addPerson(_ sender: Any) {
        if(personName.text != "" && amountExchange.text != "") {
            if let doubVal = Double(amountExchange.text!) {
                if doubVal > 0 {
                    tabs.append(TabInstance(name: (personName.text ?? ""), debt: isDebtOrLent.selectedSegmentIndex == 0, amount: doubVal, img: personImage.image ?? #imageLiteral(resourceName: "associate")))
                
                    if(isDebtOrLent.selectedSegmentIndex == 0) {
                        amountOwed += doubVal
                    } else {
                        amountLent += doubVal
                    }
                    amountLeft = amountLimit - (amountOwed + amountLent)
                    personName.text = ""
                    amountExchange.text = ""
                
                    if amountLeft < (amountLimit * 0.10) {
                        self.parent?.view.backgroundColor = lightRed
                    } else {
                        self.parent?.view.backgroundColor = lightGreen
                    }
                    navigationController?.popViewController(animated: true)
                } else {
                    amountExchange.text = ""
                    createAlert(title: "Invalid Amount", message: "Amount must be greater or equal to 0.")
                }
            } else {
                amountExchange.text = ""
                createAlert(title: "Illegal Number", message: "Please input a valid number for the amount section.")
            }
        } else {
            amountExchange.text = ""
            createAlert(title: "Illegal Field", message: "One or more fields is empty.")
        }
    }
    
    func createAlert (title:String, message:String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelOpt = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelOpt)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func exitKeyboard(_ sender: UITextField) {
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
