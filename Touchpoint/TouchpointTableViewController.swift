//
//  TouchpointTableViewController.swift
//  Touchpoint
//
//  Created by user132895 on 2/12/18.
//  Copyright © 2018 TouchPoint. All rights reserved.
//

import UIKit
import os.log


class TouchpointTableViewController: UITableViewController, UISearchBarDelegate {

    //MARK: Properties
    
    var touchpoints = [Touchpoint]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBarSetup()
        
        // Use the edit button item provied by the table view controller
        navigationItem.leftBarButtonItem = editButtonItem
        
        // Load any saved contacts, otherwise load sample data
        if let savedTouchpoints = loadTouchpoints() {
            touchpoints += savedTouchpoints
        } else {
            // Load sample data
            loadSampleTouchpoints()
        }
        
    }
    
    enum selectedScope: Int {
        case name = 0
        case org = 1
        case notes = 2
    }
    
    func searchBarSetup() {
        let searchBar = UISearchBar(frame: CGRect(x:0,y:0,width:(UIScreen.main.bounds.width),height:70))
        searchBar.showsScopeBar = true
        searchBar.scopeButtonTitles = ["Name","Organization","Notes"]
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
            touchpoints = loadTouchpoints()!
            self.tableView.reloadData()
        }
        else {
            filterTableView(ind: searchBar.selectedScopeButtonIndex, text: searchText)
        }
    }
    
    func filterTableView(ind:Int, text:String) {
        switch ind {
        case selectedScope.name.rawValue:
            touchpoints = touchpoints.filter({ (mod) -> Bool in
                return mod.name1.lowercased().contains(text.lowercased())
            }) + touchpoints.filter({ (mod) -> Bool in
                return (mod.name2?.lowercased().contains(text.lowercased()))!
            }) + touchpoints.filter({ (mod) -> Bool in
                return (mod.name3?.lowercased().contains(text.lowercased()))!
            })
            self.tableView.reloadData()
        case selectedScope.org.rawValue:
            touchpoints = touchpoints.filter({ (mod) -> Bool in
                return (mod.org1?.lowercased().contains(text.lowercased()))!
            }) + touchpoints.filter({ (mod) -> Bool in
                return (mod.org2?.lowercased().contains(text.lowercased()))!
            }) + touchpoints.filter({ (mod) -> Bool in
                return (mod.org3?.lowercased().contains(text.lowercased()))!
            })
            self.tableView.reloadData()
        case selectedScope.notes.rawValue:
            touchpoints = touchpoints.filter({ (mod) -> Bool in
                return (mod.notes?.lowercased().contains(text.lowercased()))!
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
        return touchpoints.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier
        let cellIdentifier = "TouchpointTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TouchpointTableViewCell else {
            fatalError("The dequeued cell is not an instance of TouchpointTableViewCell.")
        }
        
        // Fetches the appropriate touchpoint for the data source layout.
        let touchpoint = touchpoints[indexPath.row]
        
        cell.TPDateMonth.text = "Apr"
        cell.TPDayNumber.text = "15"
        cell.TPYearNumber.text = "2017"
        cell.contact1TextField.text = touchpoint.name1
        cell.contact2TextField.text = touchpoint.name2
        cell.contact3TextField.text = touchpoint.name3
        cell.notesTextField.text = touchpoint.notes
       
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            touchpoints.remove(at: indexPath.row)
            saveTouchpoints()
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
            os_log("Adding a new touchpoint.", log: OSLog.default, type: .debug)
        case "ShowDetail":
            guard let touchpointDetailViewController = segue.destination as? TouchpointDetailViewController else {
                fatalError("Unexpected Destination: \(segue.destination)")
            }
            guard let selectedTouchpointCell = sender as? TouchpointTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            guard let indexPath = tableView.indexPath(for: selectedTouchpointCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            let selectedTouchpoint = touchpoints[indexPath.row]
            touchpointDetailViewController.touchpoint = selectedTouchpoint
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
    
    //MARK: Actions
    
    @IBAction func unwindToTouchpointList(_ sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? TouchpointDetailViewController, let touchpoint = sourceViewController.touchpoint {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing contact
                touchpoints[selectedIndexPath.row] = touchpoint
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                // Add a new contact
                let newIndexPath = IndexPath(row: touchpoints.count, section: 0)
                
                touchpoints.append(touchpoint)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            
            // save the touchpoints
            saveTouchpoints()
        }
    }
    
    //MARK: Private Methods
    
    private func loadSampleTouchpoints() {
        guard let touchpoint1 = Touchpoint(name1: "Joe", org1: "Analog Coffee", name2: "Suzie", org2: "Calgary", name3: "Fred Jones", org3: "Camelbak", touchpointDate: "31 Jun, 2018", notes: "First time with these people, excited about the future", goals:"", photo: nil) else{
            fatalError("Unable to instantiate contact1")
        }
        
        guard let touchpoint2 = Touchpoint(name1: "Johnny", org1: "Waves Coffee", name2: "Sarah", org2: "Edmonton", name3: "Frank Smith", org3: "Nalgene", touchpointDate: "31 Mar, 2017", notes: "Second time with these people, they might be crazy", goals:"", photo: nil) else{
            fatalError("Unable to instantiate contact1")
        }
        
        touchpoints += [touchpoint1, touchpoint2]
    }
    
    private func saveTouchpoints() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(touchpoints, toFile: Touchpoint.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Touchpoints successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save touchpoints...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadTouchpoints() -> [Touchpoint]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Touchpoint.ArchiveURL.path) as? [Touchpoint]
        
    }
    
}
