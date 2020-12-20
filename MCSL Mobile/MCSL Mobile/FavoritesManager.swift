//
//  FavoritesManager.swift
//  MCSL Mobile
//
//  Created by Jerry Ji on 11/8/20.
//  Copyright © 2020 Jerry Ji. All rights reserved.
//

import Foundation
import UIKit
import CodableFirebase

class FavoritesManager: ObservableObject {
    
    typealias PersonID = String
    
    @Published
    private(set) var favoriteIDs : [PersonID] = []
    static let shared = FavoritesManager()
    
    private init() {
        let savedFavorites = UserDefaults.standard.array(forKey: "savedFavorites")
        favoriteIDs = savedFavorites as? [PersonID] ?? []
    }
    
    @Published
    private var swimmers = [PersonID : SimpleSwimmer]()
    private var isLoading = Set<PersonID>()
    func swimmer(for id: PersonID) -> SimpleSwimmer? {
        if let swimmer = swimmers[id]{
            return swimmer
        }
        if isLoading.contains(id){
            return nil
        }
        isLoading.insert(id)
        ref.child("persons").child(id).observeSingleEvent(of: .value) {(snapshot) in
            defer{
                self.isLoading.remove(id)
            }
            guard let value = snapshot.value else { return }
            do{
                let member = try FirebaseDecoder().decode(SimpleSwimmer.self, from: value)
                self.swimmers[id] = member
            } catch {
                print(error)
            }
        }
        return nil
    }
    
    func add(ID : PersonID) {
        favoriteIDs.append(ID)
        update()
    }
    
    func remove(ID: PersonID) {
        favoriteIDs.removeAll { (currentFavorite) -> Bool in
            return currentFavorite == ID
        }
        update()
    }
    
    private func update(){
        let defaults = UserDefaults.standard
        defaults.set(favoriteIDs, forKey: "savedFavorites")
    }
    
    func checkFavorites(ID: PersonID) -> Bool{
        return favoriteIDs.contains(ID)
    }
    
    func invert(ID: PersonID){
        if checkFavorites(ID: ID){
            remove(ID: ID)
        } else {
            add(ID: ID)
        }
    }
    
    func fill(ID: PersonID) -> UIImage?{
        if FavoritesManager.shared.checkFavorites(ID: ID){
            return UIImage(systemName: "star.fill")
        } else {
            return UIImage(systemName: "star")
        }
    }
}
