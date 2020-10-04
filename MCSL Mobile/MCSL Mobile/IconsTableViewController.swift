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
    let colors : [UIColor] = [UIColor.init(named: "Theme1")!, UIColor.systemRed, UIColor.systemTeal, UIColor.systemPink, UIColor.systemOrange]
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIApplication.shared.setAlternateIconName(icons[indexPath.row])
        UITabBar.appearance().barTintColor = colors[indexPath.row]
        UINavigationBar.appearance().tintColor = colors[indexPath.row]
    }

}
