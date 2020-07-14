//
//  TeamTableViewController.swift
//  MCSL Mobile
//
//  Created by Jerry Ji on 6/16/20.
//  Copyright © 2020 Jerry Ji. All rights reserved.
//

import UIKit

class TeamTableViewController: UITableViewController {
    
    var members = [(name: String, age: Int?, id: String)]()
    var teamAbr : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref.child("teams").child(teamAbr!).child("members").observe(.value) {(snapshot) in
            let values = snapshot.value as? [String: String] ?? [:]
            self.members.removeAll(keepingCapacity: true)
            for member in values.sorted(by: { (m1, m2) in
                m1.value < m2.value
            }){
                ref.child("persons").child(member.key).child("age").observeSingleEvent(of: .value) { (snapshot) in
                    let age = snapshot.value as? Int
                    self.members.append((name: member.value, age: age, id: member.key))
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return members.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "teamMember", for: indexPath)
        let theMember = members[indexPath.row]
        cell.textLabel!.text = theMember.name
        if let age = theMember.age{
            cell.detailTextLabel!.text = "\(teamAbr!) | \(age)"
        } else {
            cell.detailTextLabel!.text = "\(teamAbr!)"
        }
        // Configure the cell...
        
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
        let cell = sender as! UITableViewCell
        let memberLocation = tableView.indexPath(for: cell)
        let memberID = members[memberLocation!.row].id
        let destinationVC = segue.destination as! MemberTableViewController
        destinationVC.id = memberID
    }
}
