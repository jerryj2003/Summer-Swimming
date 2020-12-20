//
//  FavoritesViewController.swift
//  MCSL Mobile
//
//  Created by Jerry Ji on 12/13/20.
//  Copyright © 2020 Jerry Ji. All rights reserved.
//

import UIKit
import SwiftUI

class FavoritesViewController: UIHostingController<FavoritesView> {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: FavoritesView())
    }
}
