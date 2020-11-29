//
//  FavoritesView.swift
//  MCSL Mobile
//
//  Created by Jerry Ji on 11/29/20.
//  Copyright © 2020 Jerry Ji. All rights reserved.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject
    var manager = FavoritesManager.shared
    var list: some View {
        List(manager.favoriteIDs, id:\.self){ id in
            if let swimmer = manager.swimmer(for: id) {
                Text(swimmer.name)
            } else {
                Text("Loading...")
                
            }
        }
    }
    var body: some View {
        if #available(iOS 14.0, *) {
            list
                .listStyle(InsetGroupedListStyle())
        } else {
            // Fallback on earlier versions
            list
                .listStyle(GroupedListStyle())
        }
        
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
