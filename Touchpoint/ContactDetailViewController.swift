//
//  ContactDetailViewController.swift
//  Touchpoint
//
//  Created by user132895 on 1/8/18.
//  Copyright © 2018 TouchPoint. All rights reserved.
//

import UIKit
import os.log

class ContactDetailViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: Properties
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var orgTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var addressStreetTextField: UITextField!
    @IBOutlet weak var addressCityTextField: UITextField!
    @IBOutlet weak var addressProvStateTextField: UITextField!
    @IBOutlet weak var addressCodeTextField: UITextField!
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
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    /*
        This value is either passed by 'ContactTableViewController' in 'prepare(for:sender:)'
        or constructed as part of adding a new meal
    */
    var contact: Contact?

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
        
    }
    
    //MARK: Navigation
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let name = nameTextField.text ?? ""
        let org = orgTextField.text ?? ""
        let phone = phoneTextField.text ?? ""
        let addressStreet = addressStreetTextField.text ?? ""
        let addressCity = addressCityTextField.text ?? ""
        let addressProvState = addressProvStateTextField.text ?? ""
        let addressCode = addressCodeTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let frequency = frequencyTextField.text ?? ""
        let lastTPDate = lastTPDateTextField.text ?? ""
        let birthday = birthdayTextField.text ?? ""
        let note = noteTextField.text ?? ""
      
        
        // Set the contact to be passed to ContactTableViewController after the unwind segue.
        contact = Contact(name: name, org: org, phone: phone, addressStreet: addressStreet, addressCity: addressCity, addressProvState: addressProvState, addressCode: addressCode, email: email, frequency: frequency, lastTPDate: lastTPDate, birthday: birthday, note: note)
    }

}

