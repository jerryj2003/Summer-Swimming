//
//  IconsTableViewController.swift
//  MCSL Mobile
//
//  Created by Jerry Ji on 8/16/20.
//  Copyright © 2020 Jerry Ji. All rights reserved.
//
/*
 To add new icon:
 1. Import icon@2x(120) and icon@3x(180)
 2. Add new row in Storyboard with image and name of the new icon
 3. Add icon to info.plist
 4. Add icon name to icons array in IconsTableViewController
 */

import UIKit

class IconsTableViewController: UITableViewController {
    //nil is the default icon
    let icons : [String?] = [nil, "beach", "luminous", "midnight", "galaxy", "dark"]
//    let colors : [UIColor] = [UIColor.init(named: "Theme1")!, UIColor.systemRed, UIColor.systemTeal, UIColor.systemPink, UIColor.systemOrange]
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIApplication.shared.setAlternateIconName(icons[indexPath.row])
//        UITabBar.appearance().backgroundColor = colors[indexPath.row]
//        UINavigationBar.appearance().backgroundColor = colors[indexPath.row]
    }

}
