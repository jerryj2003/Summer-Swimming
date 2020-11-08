//
//  FavoritesManager.swift
//  MCSL Mobile
//
//  Created by Jerry Ji on 11/8/20.
//  Copyright © 2020 Jerry Ji. All rights reserved.
//

import Foundation

class FavoritesManager {
    
    var favoriteIDs : [String] = []
    static let shared = FavoritesManager()
    private init() {
    }
    
    func add(ID : String) {
        favoriteIDs.append(ID)
    }
    
    func remove(ID: String) {
        favoriteIDs.removeAll { (currentFavorite) -> Bool in
            if currentFavorite == ID {
                return true
            }
            return false
        }
    }
}
