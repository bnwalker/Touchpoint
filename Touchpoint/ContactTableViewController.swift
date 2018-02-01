//
//  ContactTableViewController.swift
//  Touchpoint
//
//  Created by user132895 on 1/15/18.
//  Copyright © 2018 TouchPoint. All rights reserved.
//

import UIKit
import os.log

enum selectedScope: Int {
    case name = 0
    case org = 1
    case city = 2
}

class ContactTableViewController: UITableViewController, UISearchBarDelegate {
    
    //MARK: Properties
    
    var contacts = [Contact]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBarSetup()
        
        // Use the edit button item provied by the table view controller
        navigationItem.leftBarButtonItem = editButtonItem
        
        // Load any saved contacts, otherwise load sample data
        if let savedContacts = loadContacts() {
            contacts += savedContacts
        } else {
            // Load sample data
            loadSampleContacts()
        }
        
    }
    
    func searchBarSetup() {
        let searchBar = UISearchBar(frame: CGRect(x:0,y:0,width:(UIScreen.main.bounds.width),height:70))
        searchBar.showsScopeBar = true
        searchBar.scopeButtonTitles = ["Name","Organization","City"]
        searchBar.selectedScopeButtonIndex = 0
        searchBar.delegate = self
        
        self.tableView.tableHeaderView = searchBar
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Search Bar Delegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            contacts = loadContacts()!
            self.tableView.reloadData()
        }
        else {
            filterTableView(ind: searchBar.selectedScopeButtonIndex, text: searchText)
        }
    }
    
    func filterTableView(ind:Int, text:String) {
        switch ind {
        case selectedScope.name.rawValue:
                contacts = contacts.filter({ (mod) -> Bool in
                    return mod.name.lowercased().contains(text.lowercased())
            })
            self.tableView.reloadData()
        case selectedScope.org.rawValue:
                contacts = contacts.filter({ (mod) -> Bool in
                    return (mod.org?.lowercased().contains(text.lowercased()))!
                })
                self.tableView.reloadData()
        case selectedScope.city.rawValue:
                contacts = contacts.filter({ (mod) -> Bool in
                    return (mod.addressCity?.lowercased().contains(text.lowercased()))!
                })
                self.tableView.reloadData()
        default:
            print("no type")
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return contacts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier
        let cellIdentifier = "ContactTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ContactTableViewCell else {
            fatalError("The dequeued cell is not an instance of ContactTableViewCell.")
        }
        
        // Fetches the appropriate contact for the data source layout.
        let contact = contacts[indexPath.row]
        
        cell.nameLabel.text = contact.name
        cell.orgLabel.text = contact.org
        cell.cityLabel.text = contact.addressCity
        cell.provStateLabel.text = contact.addressProvState
        cell.lastTPBkgnd.backgroundColor = UIColor.red
        cell.lastTPBkgnd.layer.cornerRadius = 10
        
        return cell
    }


    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }


    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            contacts.remove(at: indexPath.row)
            saveContacts()
            tableView.deleteRows(at: [indexPath], with: .fade)
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


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch(segue.identifier ?? "") {
        case "AddItem":
            os_log("Adding a new contact.", log: OSLog.default, type: .debug)
        case "ShowDetail":
            guard let contactDetailViewController = segue.destination as? ContactDetailViewController else {
                fatalError("Unexpected Destination: \(segue.destination)")
                }
            guard let selectedContactCell = sender as? ContactTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
                }
            guard let indexPath = tableView.indexPath(for: selectedContactCell) else {
                fatalError("The selected cell is not being displayed by the table")
                }
            let selectedContact = contacts[indexPath.row]
            contactDetailViewController.contact = selectedContact
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
    
    //MARK: Actions
    
    @IBAction func unwindToContactList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? ContactDetailViewController, let contact = sourceViewController.contact {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing contact
                contacts[selectedIndexPath.row] = contact
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
            // Add a new contact
            let newIndexPath = IndexPath(row: contacts.count, section: 0)
            
            contacts.append(contact)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            
            // save the contacts
            saveContacts()
        }
    }
    
    //MARK: Private Methods
    
    private func loadSampleContacts() {
        guard let contact1 = Contact(name: "Jim", org: "Waves", phone: "604-202-1070", textMsg: "604-287-9098", addressStreet: "23 45th Street", addressCity: "Vancouver", addressProvState: "BC", addressCode: "F5G 6H8", email: "jim@gmail.com", frequency: "Quarterly", lastTPDate: "10Apr2017", birthday: "23Oct1978", note: "Loves Strawberries") else{
            fatalError("Unable to instantiate contact1")
        }
        
        guard let contact2 = Contact(name: "Julie", org: "Waves", phone: "604-212-4444", textMsg: "489-098-8765", addressStreet: "76 45th Street", addressCity: "Vancouver", addressProvState: "BC", addressCode: "F5G 6H8", email: "jim@gmail.com", frequency: "Quarterly", lastTPDate: "10Apr2017", birthday: "23Oct1978", note: "Loves Strawberries") else{
            fatalError("Unable to instantiate contact2")
        }
    
        contacts += [contact1, contact2]
    }
    
    private func saveContacts() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(contacts, toFile: Contact.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Contacts successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save contacts...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadContacts() -> [Contact]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Contact.ArchiveURL.path) as? [Contact]
    }
    
}
