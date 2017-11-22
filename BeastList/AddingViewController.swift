//
//  AddingViewController.swift
//  BeastList
//
//  Created by elva wang on 11/18/17.
//  Copyright © 2017 elva wang. All rights reserved.
//

import Foundation
import UIKit

class AddingViewController: UIViewController {
    var delegate: BeastDelegation?
    var prePopulate : String?
    var indexPath: NSIndexPath?
//    var Addinglabel: String?
    @IBOutlet weak var AddingLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AddingLabel.text = prePopulate
    }
    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
         delegate?.cancelFunc(by: self)
    }
    @IBAction func DonePressed(_ sender: UIBarButtonItem) {
        let text = AddingLabel.text!
        delegate?.doneFunc(by: self, title: text, at: indexPath)
    }
    
        
}
