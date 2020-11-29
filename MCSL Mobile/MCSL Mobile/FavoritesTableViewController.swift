//
//  FavoritesTableViewController.swift
//  MCSL Mobile
//
//  Created by Jerry Ji on 11/8/20.
//  Copyright © 2020 Jerry Ji. All rights reserved.
//

import UIKit
import CodableFirebase

class FavoritesTableViewController: UITableViewController {
    
    var favoriteIDs : [String] {FavoritesManager.shared.favoriteIDs}
    lazy var members = [SimpleSwimmer?].init(repeating: nil, count: self.favoriteIDs.count)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        for i in favoriteIDs.indices{
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteIDs.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath)
        if let member = members[indexPath.row]{
        cell.textLabel!.text = member.name
        cell.detailTextLabel!.text = "\(member.team) | \(member.age)"
        }
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
    
  
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        let memberLocation = tableView.indexPath(for: cell)
        let memberID = favoriteIDs[memberLocation!.row]
        let memberName = members[memberLocation!.row]?.name ?? ""
        let destinationVC = segue.destination as! MemberTableViewController
        destinationVC.id = memberID
        destinationVC.title = memberName
     }
    
}
