//
//  HomeTableViewController.swift
//  MCSL Mobile
//
//  Created by Jerry Ji on 5/3/20.
//  Copyright © 2020 Jerry Ji. All rights reserved.
//

import UIKit


class HomeTableViewController: UITableViewController {

    var divisions = [String]()
    var teams = [[String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref.observe(.value) {(snapshot) in
            let values = snapshot.value as? [
                String: [String: AnyObject]
            ] ?? [:]
            self.divisions.removeAll(keepingCapacity: true)
            self.teams.removeAll(keepingCapacity: true)
            
            for (index, divisions) in values.sorted(by: { (division1, divisison2) in
                division1.key < divisison2.key
            }).enumerated() {
                self.divisions.append(divisions.key)
                self.teams.append([])
                for team in divisions.value {
                    self.teams[index].append(team.key)
                }
            }
            self.tableView.reloadData()
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return divisions.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Team Cells", for: indexPath)
        cell.textLabel?.text = teams[indexPath.section][indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return divisions[section]
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return divisions.map(shortenDivision)
    }
    
    func shortenDivision(division: String) -> String{
        return String(division.suffix(1))
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
