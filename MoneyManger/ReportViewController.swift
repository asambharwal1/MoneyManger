//
//  ReportViewController.swift
//  MoneyManger
//
//  Created by Aashish Sambharwal on 3/3/18.
//  Copyright © 2018 TeamMoney. All rights reserved.
//

import UIKit

class ReportViewController: UIViewController {
    
    @IBOutlet weak var amountAvailable: UILabel!
    @IBOutlet weak var t_amountLeft: UILabel!
    @IBOutlet weak var t_amountOwed: UILabel!
    @IBOutlet weak var t_amountLent: UILabel!
    
    func getConverted (amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: amount))!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        amountLeft = (amountLimit - (amountOwed + amountLent))
        amountAvailable.text = "\(getConverted(amount: amountLimit))"
        t_amountOwed.text = "\(getConverted(amount: amountOwed))"
        t_amountLent.text = "\(getConverted(amount: amountLent))"
        t_amountLeft.text = "\(getConverted(amount: amountLeft))"
        
        if amountLeft < (amountLimit * 0.10) {
            self.view.backgroundColor = lightRed
        } else {
            self.view.backgroundColor = lightGreen
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
