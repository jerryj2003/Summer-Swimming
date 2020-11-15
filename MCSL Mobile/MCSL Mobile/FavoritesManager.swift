//
//  FavoritesManager.swift
//  MCSL Mobile
//
//  Created by Jerry Ji on 11/8/20.
//  Copyright © 2020 Jerry Ji. All rights reserved.
//

import Foundation
import UIKit

class FavoritesManager {
    
    private(set) var favoriteIDs : [String] = []
    static let shared = FavoritesManager()
    
    private init() {
        let savedFavorites = UserDefaults.standard.array(forKey: "savedFavorites")
        favoriteIDs = savedFavorites as? [String] ?? []
    }
    
    func add(ID : String) {
        favoriteIDs.append(ID)
        update()
    }
    
    func remove(ID: String) {
        favoriteIDs.removeAll { (currentFavorite) -> Bool in
            return currentFavorite == ID
        }
        update()
    }
    
    private func update(){
        let defaults = UserDefaults.standard
        defaults.set(favoriteIDs, forKey: "savedFavorites")
    }
    
    func checkFavorites(ID: String) -> Bool{
        return favoriteIDs.contains(ID)
    }
    
    func invert(ID: String){
        if checkFavorites(ID: ID){
            remove(ID: ID)
        } else {
            add(ID: ID)
        }
    }
    
    func fill(ID: String) -> UIImage?{
        if FavoritesManager.shared.checkFavorites(ID: ID){
            return UIImage(systemName: "star.fill")
        } else {
            return UIImage(systemName: "star")
        }
    }
}
