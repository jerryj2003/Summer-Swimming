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
        favoriteIDs = [
            "e70438eb7f13cfdb981e59eee47435af8824d9012610b6aacf4414b4",
            "e70e26d95626b34022756eafbdde2d9de026a2d59298da6148e3981d",
            "e71379e4b5d6f95e65c3834b3b9dbf13d6d8f5c7d30b183d72e17ad6",
            "e724a0148bfa68f1c5ccb62d4b679548ae6ccf6020a2f46db7715f24",
            "e72526f4054b6659ce9ae175a4e10ce1adc95daba3a8f61dc3228398",
            "e72cc56a5d2841c1cbf0fa648068ec335030c462d79bb66669957a06",
            "e72d685f9ab1623469cd4c3082673b9d7fe8ab80cfc297ca47dbff3d"
        ]
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
