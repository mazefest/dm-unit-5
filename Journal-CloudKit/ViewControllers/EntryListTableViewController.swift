//
//  EntryListTableViewController.swift
//  Journal-CloudKit
//
//  Created by Colby Mehmen on 7/18/23.
//

import UIKit

class EntryListTableViewController: UITableViewController {
    
    var entries: [Entry] = []
    let entryController = EntryController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        entryController.fetchEntriesWith { result in
            switch result {
            case .success(let entries):
                print("we got \(entries?.count) entries")
                guard let entries = entries else {
                    return
                }
                DispatchQueue.main.async {
                    self.entries = entries
                    self.tableView.reloadData()
                }
            case .failure(let failure):
                print("we failed fetch all the stuff we needed")
                // we failed
                break;
            }
        }
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    @IBAction func onAddEntryButtonTapped(_ sender: UIBarButtonItem) {
        // segue to another sheet
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print(entries.count)
        return entries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EntryConstants.EntryCellIdentifier, for: indexPath)
        let entry = entries[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = entry.title
        print(entry.title)
        cell.contentConfiguration = content
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
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueConstants.toEditEntry {
            guard let index = tableView.indexPathForSelectedRow?.row else {
                return
            }
            let entry = self.entries[index]
            let destination = segue.destination  as! EntryDetailViewController
            destination.entry = entry
            destination.delegate = self
            
            
        } else if segue.identifier == SegueConstants.toNewEntry {
            let destination = segue.destination  as! EntryDetailViewController
            destination.delegate = self
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}

extension EntryListTableViewController: EntryDetailViewControllerDelegate {
    func onSave(entry: Entry?, title: String, body: String) {
        print("on save")
        if entry == nil {
            print("here")
            DispatchQueue.main.async {
                EntryController.shared.create(title: title, body: body) { result in
                    switch result {
                    case .success(_):
                        print("yeet")
                    case .failure(let failure):
                        let alert = UIAlertController(title: "ERROR", message: "\(failure.localizedDescription)", preferredStyle: .alert)
                        alert.addAction(.init(title: "Ok", style: .default))
                        self.present(alert, animated: true, completion: nil)
                    }
                    self.tableView.reloadData()
                }
            }
        } else {
            // update the entry we have
        }
        

    }
}
