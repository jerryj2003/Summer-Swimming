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
    lazy var searchTableViewController = SearchTableViewController(tableView: tableView)
    
    let searchController = UISearchController(searchResultsController: nil)
    var isSearching : Bool{
        return searchController.searchBar.text?.isEmpty == false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTableViewController.viewDidLoad()
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
                for team in divisions.value.sorted(by: { (team1, team2) -> Bool in
                    (team1.value as! String) < (team2.value as! String)}) {
                    self.teams[index].append((team.value as! String, team.key))
                }
            }
            self.tableView.reloadData()
        }
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        //Removes background during new search
        searchController.obscuresBackgroundDuringPresentation = false
        //Changes search bar placeholder to "Search Swimmer"
        searchController.searchBar.placeholder = "Search Swimmer"
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchTerm = searchController.searchBar.text
        searchTableViewController.searchTerm = searchTerm
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        if isSearching{
            return searchTableViewController.numberOfSections(in: tableView)
        }
        return divisions.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching{
            return searchTableViewController.tableView(tableView, numberOfRowsInSection: section)
        }
        return teams[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isSearching{
            return searchTableViewController.tableView(tableView, cellForRowAt: indexPath)
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "Team Cells", for: indexPath)
        cell.textLabel?.text = teams[indexPath.section][indexPath.row].teamFull
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if isSearching{
            return "NAMES STARTING WITH \"\(searchController.searchBar.text!)\""
        }
        return "Division \(divisions[section])"
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        if isSearching{
            return nil
        }
        return divisions.map(shortenDivision)
    }
    
    func shortenDivision(division: String) -> String{
        return String(division.suffix(1))
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if isSearching{
            //Dismisses the keyboard when navigating to next page
            searchController.searchBar.searchTextField.resignFirstResponder()
            return searchTableViewController.prepare(for: segue, sender: sender)
        }
        let cell = sender as! UITableViewCell
        let teamLocation = tableView.indexPath(for: cell)
        let abr = teams[teamLocation!.section][teamLocation!.row].teamAbr
        let destinationVC = segue.destination as! TeamTableViewController
        destinationVC.teamAbr = abr
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }


}
