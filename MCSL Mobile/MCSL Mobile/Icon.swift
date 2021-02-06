//
//  Icon.swift
//  MCSL Mobile
//
//  Created by Jerry Ji on 1/23/21.
//  Copyright © 2021 Jerry Ji. All rights reserved.
//

import Foundation

struct Icon : Identifiable{
    var id = UUID()
    //Name of icon file
    let fileName : String
    //Name displayed in app
    let displayName : String
    //Name linking id to icon
    let identifierName: String?
}
