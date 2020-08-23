//
//  HomeTableViewController.swift
//  MCSL Mobile
//
//  Created by Jerry Ji on 5/3/20.
//  Copyright © 2020 Jerry Ji. All rights reserved.
//

import UIKit


class HomeTableViewController: UITableViewController, UISearchResultsUpdating {

    var divisions = [String]()
    var teams = [[(teamFull: String, teamAbr: String)]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref.child("divisions").observe(.value) {(snapshot) in
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
                    self.teams[index].append((team.value as! String, team.key))
                }
            }
            self.tableView.reloadData()
        }
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let searchResult = storyBoard.instantiateViewController(identifier: "searchTableView")
        let searchController = UISearchController(searchResultsController: searchResult)
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchTerm = searchController.searchBar.text
        let searchResultCotroller = searchController.searchResultsController as! SearchTableViewController
        searchResultCotroller.searchTerm = searchTerm
        searchResultCotroller.update()
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
        cell.textLabel?.text = teams[indexPath.section][indexPath.row].teamFull
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
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        let teamLocation = tableView.indexPath(for: cell)
        let abr = teams[teamLocation!.section][teamLocation!.row].teamAbr
        let destinationVC = segue.destination as! TeamTableViewController
        destinationVC.teamAbr = abr
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }


}
