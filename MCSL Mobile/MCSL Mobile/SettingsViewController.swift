//
//  SettingsViewController.swift
//  MCSL Mobile
//
//  Created by Jerry Ji on 12/13/20.
//  Copyright © 2020 Jerry Ji. All rights reserved.
//

import UIKit
import SwiftUI

class SettingsViewController: UIHostingController<SettingsView> {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: SettingsView())
    }
}
