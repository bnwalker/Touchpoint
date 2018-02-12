//
//  TouchpointDetailViewController.swift
//  Touchpoint
//
//  Created by user132895 on 2/3/18.
//  Copyright © 2018 TouchPoint. All rights reserved.
//

import UIKit
import os.log

class TouchpointDetailViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var TPDateTextField: UITextField!
    @IBOutlet weak var timeSinceTP: UITextField!
    @IBOutlet weak var contact1TextField: UITextField!
    @IBOutlet weak var org1TextField: UITextField!
    @IBOutlet weak var contact2TextField: UITextField!
    @IBOutlet weak var org2TextField: UITextField!
    @IBOutlet weak var contact3TextField: UITextField!
    @IBOutlet weak var org3TextField: UITextField!
    @IBOutlet weak var contact4TextField: UITextField!
    @IBOutlet weak var org4TextField: UITextField!
    @IBOutlet weak var notesTextField: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    var touchpoint: Touchpoint?
    var contacts = [Contact] ()
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeSinceTP.text = "0 Days"
        
        // Handle the text field user input through delegate callbacks.
        TPDateTextField.delegate = self
        contact1TextField.delegate = self
        contact2TextField.delegate = self
        contact3TextField.delegate = self
        contact4TextField.delegate = self
        notesTextField.delegate = self
        
        createDatePicker()
        createContactPicker()
        
        // Set up views if editing an existing contact
        if let touchpoint = touchpoint {
            navigationItem.title = "Touchpoint Details"
            TPDateTextField.text = touchpoint.touchpointDate
            contact1TextField.text = touchpoint.name1
            org1TextField.text = touchpoint.org1
            contact2TextField.text = touchpoint.name2
            org2TextField.text = touchpoint.org2
            contact3TextField.text = touchpoint.name3
            org3TextField.text = touchpoint.org3
            contact4TextField.text = touchpoint.name4
            org4TextField.text = touchpoint.org4
            notesTextField.text = touchpoint.notes
        }
        
        timeSinceTP.backgroundColor = UIColor.orange
        timeSinceTP.layer.cornerRadius = 10
        
        // Enable the save button only if the text field has a valid contact name
        updateSaveButtonState()
        if let savedContacts = loadContacts() {
            contacts += savedContacts
        }
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
        updateSaveButtonState()
        navigationItem.title = "New Touchpoint"
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the save button when editing
        saveButton.isEnabled = false
    }
    
    //MARK: Date Picker for Touchpoint Date
    
    let datePicker = UIDatePicker()
    
    func createDatePicker () {
        
        // format date
        datePicker.datePickerMode = .date
        
        // toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // bar button item
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(touchpointDateDonePressed))
        toolbar.setItems([doneButton], animated: false)
        
        TPDateTextField.inputAccessoryView = toolbar
        
        // assigning date picker to text field
        TPDateTextField.inputView = datePicker
    
    }
    
    @objc func touchpointDateDonePressed() {
        // format date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        TPDateTextField.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
        
        // updating days since touchpoint field
        let now = Date()
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.day, .month, .year]
        formatter.maximumUnitCount = 1
        let TPDate = datePicker.date
        
        timeSinceTP.text = formatter.string(from: TPDate , to: now)
    }
    
    //MARK: Contact Name Picker
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return contacts.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent: Int) -> String? {
        let contactNames = contacts.map { $0.name }
        return contactNames[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let contactNames = contacts.map { $0.name }
        let orgNames = contacts.map { $0.org }
        contact2TextField.text = contactNames[row]
        org2TextField.text = orgNames[row]

    }
    
    func createContactPicker () {
        let contact1Picker = UIPickerView()
        contact1Picker.delegate = self
        let contact2Picker = UIPickerView()
        contact2Picker.delegate = self
        
        // toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // bar button item
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(touchpointContactDonePressed))
        toolbar.setItems([doneButton], animated: false)
        
        contact1TextField.inputAccessoryView = toolbar
        contact2TextField.inputAccessoryView = toolbar
        
        // assigning contact picker to text field
        contact1TextField.inputView = contact1Picker
        contact2TextField.inputView = contact2Picker

    }
    
    @objc func touchpointContactDonePressed() {
   
        view.endEditing(true)
    }
    
    //MARK: Navigation
    

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push), this view controller needs to be dismissed in two different ways.
        print("The cancel button was pressed")
        let isPresentinginAddTouchpointMode = presentingViewController != nil
        if isPresentinginAddTouchpointMode {
            print("The cancel button was pressed in add touchpoint mode")
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController {
            print("The cancel button was pressed in edit touchpoint mode")
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The TouchpointDetailViewController is not inside a navigation controller")
        }
    }
    
    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let name1 = contact1TextField.text ?? ""
        let org1 = org1TextField.text ?? ""
        let name2 = contact2TextField.text ?? ""
        let org2 = org2TextField.text ?? ""
        let name3 = contact3TextField.text ?? ""
        let org3 = org3TextField.text ?? ""
        let name4 = contact4TextField.text ?? ""
        let org4 = org4TextField.text ?? ""
        let notes = notesTextField.text ?? ""
        let touchpointDate = TPDateTextField.text ?? ""
        
        // Set the contact to be passed to ContactTableViewController after the unwind segue.
        touchpoint = Touchpoint(name1: name1, org1: org1, name2: name2, org2: org2, name3: name3, org3: org3, name4: name4, org4: org4, touchpointDate: touchpointDate, notes: notes, goals: "", photo: nil)
    }
    
    //MARK: Actions
    
    
    
    //MARK: Private Methods
    
    private func updateSaveButtonState() {
        // Disable the save button if the Name 1 text field is empty
        let text = contact1TextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    private func loadContacts() -> [Contact]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Contact.ArchiveURL.path) as? [Contact]
        
    }

}
