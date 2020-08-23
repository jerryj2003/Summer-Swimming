//
//  IconsTableViewController.swift
//  MCSL Mobile
//
//  Created by Jerry Ji on 8/16/20.
//  Copyright © 2020 Jerry Ji. All rights reserved.
//

import UIKit

class IconsTableViewController: UITableViewController {
    //nil is the default icon
    let icons : [String?] = [nil, "beach", "luminous", "midnight", "galaxy"]
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIApplication.shared.setAlternateIconName(icons[indexPath.row])
    }

}
