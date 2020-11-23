//
//  Swimmer.swift
//  MCSL Mobile
//
//  Created by Jerry Ji on 4/5/20.
//  Copyright © 2020 Jerry Ji. All rights reserved.
//

import Foundation
struct EventInfo: Codable {
    let event: String
    let seed: String?
    let final: String
}
struct Swimmer: Codable {
    let name: String
    let age: Int
    let team: String
    let events: [String:[EventInfo]]
}

struct SimpleSwimmer : Codable{
    var name : String
    var age : Int
    var team : String
}
