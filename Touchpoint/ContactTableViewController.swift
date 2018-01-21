//
//  ContactTableViewController.swift
//  Touchpoint
//
//  Created by user132895 on 1/15/18.
//  Copyright © 2018 TouchPoint. All rights reserved.
//

import UIKit

class ContactTableViewController: UITableViewController {
    
    //MARK: Properties
    
    var contacts = [Contact]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load sample data
        loadSampleContacts()

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

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: Actions
    
    @IBAction func unwindToContactList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? ContactDetailViewController, let contact = sourceViewController.contact {
            // Add a new contact
            let newIndexPath = IndexPath(row: contacts.count, section: 0)
            
            contacts.append(contact)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
    
    //MARK: Private Methods
    
    private func loadSampleContacts() {
        guard let contact1 = Contact(name: "Jim", org: "Waves", phone: "604-202-1070", addressStreet: "23 45th Street", addressCity: "Vancouver", addressProvState: "BC", addressCode: "F5G 6H8", email: "jim@gmail.com", frequency: "Quarterly", lastTPDate: "10Apr2017", birthday: "23Oct1978", note: "Loves Strawberries") else{
            fatalError("Unable to instantiate contact1")
        }
        
        guard let contact2 = Contact(name: "Julie", org: "Waves", phone: "604-212-4444", addressStreet: "76 45th Street", addressCity: "Vancouver", addressProvState: "BC", addressCode: "F5G 6H8", email: "jim@gmail.com", frequency: "Quarterly", lastTPDate: "10Apr2017", birthday: "23Oct1978", note: "Loves Strawberries") else{
            fatalError("Unable to instantiate contact1")
        }
    
        contacts += [contact1, contact2]
    }
    
}
