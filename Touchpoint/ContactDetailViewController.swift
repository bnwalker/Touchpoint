//
//  ContactDetailViewController.swift
//  Touchpoint
//
//  Created by user132895 on 1/8/18.
//  Copyright © 2018 TouchPoint. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: Properties
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var orgTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var addressStreetTextField: UITextField!
    @IBOutlet weak var addressSecondLineTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var frequencyTextField: UITextField!
    @IBOutlet weak var lastTPDateTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var noteTextField: UITextField!
    @IBAction func increaseFrequencyButton(_ sender: UIButton) {
        if frequencyTextField.text == "Quarterly" {
            frequencyTextField.text = "Monthly"
        }
        else if frequencyTextField.text == "Semiannually" {
            frequencyTextField.text = "Quarterly"
        }
    }
    @IBAction func decreaseFrequencyButton(_ sender: UIButton) {
        if frequencyTextField.text == "Quarterly" {
            frequencyTextField.text = "Semiannually"
        }
        else if frequencyTextField.text == "Monthly" {
            frequencyTextField.text = "Quarterly"
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field user input through delegate callbacks.
        nameTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        nameTextField.text = textField.text
    }

}

