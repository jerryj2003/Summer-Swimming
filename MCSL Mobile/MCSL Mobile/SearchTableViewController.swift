//
//  SearchTableViewController.swift
//  MCSL Mobile
//
//  Created by Jerry Ji on 8/23/20.
//  Copyright © 2020 Jerry Ji. All rights reserved.
//

import UIKit
import CodableFirebase

class SearchTableViewController: UITableViewController {

    var searchTerm : String?
    var searchResult = [Swimmer]()
    
    func update() {
        guard searchTerm != nil
            else {
                return
        }
        ref.child("persons").queryOrdered(byChild: "searchTerm").queryStarting(atValue: searchTerm?.lowercased()).queryEnding(atValue: searchTerm!.lowercased() + "\u{f8ff}").observeSingleEvent(of: .value) { (snapshot) in
            guard let value = snapshot.value else{ return }
            do {
                let resultDict = try FirebaseDecoder().decode([String:Swimmer].self, from: value).sorted(by: { (swimmer1, swimmer2) -> Bool in
                    swimmer1.value.name < swimmer2.value.name
                })
                self.searchResult = resultDict.map({ (arg0) -> Swimmer in
                    
                    let (_, value) = arg0
                    return value
                })
                self.tableView.reloadData()
            } catch {
                print(error)
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResult.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath)
        cell.textLabel?.text = searchResult[indexPath.row].name
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
