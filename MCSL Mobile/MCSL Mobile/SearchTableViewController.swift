//
//  SearchTableViewController.swift
//  MCSL Mobile
//
//  Created by Jerry Ji on 8/23/20.
//  Copyright © 2020 Jerry Ji. All rights reserved.
//

import UIKit
import CodableFirebase
import DZNEmptyDataSet

class SearchTableViewController: NSObject, UITableViewDataSource, UITableViewDelegate, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    init(tableView : UITableView) {
        self.searchTableView = tableView
    }
    let searchTableView : UITableView
    
    var searchTerm : String?{
        didSet{
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (_) in
                self.update()
            }
            if searchTerm?.isEmpty == false{
                searchResult = []
                loadingIndicator.startAnimating()
                searchTableView.reloadData()
            }
        }
    }
    var searchResult = [(swimmerInfo: SimpleSwimmer, ID: String)]()
    var timer : Timer?
    var loadingIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    
    func update() {
        guard searchTerm != nil && searchTerm != ""
        else {
            update(to: [], for: searchTerm)
            return
        }
        let searchTermCopy = searchTerm!
        ref.child("persons").queryOrdered(byChild: "searchTerm").queryStarting(atValue: searchTerm?.lowercased()).queryEnding(atValue: searchTerm!.lowercased() + "\u{f8ff}").observeSingleEvent(of: .value) { (snapshot) in
            guard let value = snapshot.value else {
                self.update(to: [], for: searchTermCopy)
                return
            }
            DispatchQueue.global().async {
                do {
                    if self.searchTerm != searchTermCopy{
                        return
                    }
                    let resultDict = try FirebaseDecoder().decode([String:SimpleSwimmer].self, from: value).sorted(by: { (swimmer1, swimmer2) -> Bool in
                        swimmer1.value.name < swimmer2.value.name
                    })
                    let searchResultCopy : [(swimmerInfo: SimpleSwimmer, ID: String)]
                    searchResultCopy = resultDict.map({ (arg0) in
                        let (ID, value) = arg0
                        return (value, ID)
                    })
                    self.update(to: searchResultCopy, for: searchTermCopy)
                } catch {
                    print(error)
                    self.update(to: [], for: searchTermCopy)
                }
            }
        }
    }
    
    func update(to results: [(swimmerInfo: SimpleSwimmer, ID: String)], for searchTerm: String?){
        if searchTerm == self.searchTerm{
            searchResult = results
            DispatchQueue.main.async {
                self.loadingIndicator.stopAnimating()
                self.searchTableView.reloadData()
            }
        }
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        
        var emptyText = "No Swimmers Found"
        if loadingIndicator.isAnimating{
            emptyText = "Searching..."
        }
        return NSAttributedString(string: emptyText)
    }
    
    func viewDidLoad() {
        searchTableView.emptyDataSetSource = self
        searchTableView.emptyDataSetDelegate = self
        loadingIndicator.center = searchTableView.center
        loadingIndicator.hidesWhenStopped = true
        searchTableView.addSubview(loadingIndicator)
        loadingIndicator.color = #colorLiteral(red: 0.9637133479, green: 0.7429386973, blue: 0.3061919808, alpha: 1)
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath)
        let info = searchResult[indexPath.row].swimmerInfo
        cell.textLabel?.text = info.name
        cell.detailTextLabel?.text = "\(info.team) | \(info.age)"
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
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        let memberLocation = searchTableView.indexPath(for: cell)
        let memberID = searchResult[memberLocation!.row].ID
        let memberName = searchResult[memberLocation!.row].swimmerInfo.name
        let destinationVC = segue.destination as! MemberTableViewController
        destinationVC.id = memberID
        destinationVC.title = memberName
     }
     
    
}
