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
            NavigationLink(destination: MemberView(id:id, name: manager.swimmer(for: id)?.name ?? "")) {
                HStack{
                    Image(systemName: "star.fill")
                        .foregroundColor(.accentColor)
                        .onTapGesture {
                            manager.invert(ID: id)
                        } 
                    VStack(alignment:.leading){
                        if let swimmer = manager.swimmer(for: id) {
                            Text(swimmer.name)
                        } else {
                            Text("Loading...")
                        }
                        
                        if let swimmer = manager.swimmer(for: id) {
                            Text("\(swimmer.team) | \(swimmer.age)")
                                .font(.caption)
                        } else {
                            Text("")
                                .font(.caption)
                            
                        }
                        
                    }
                }
            }
        }
        .animation(.easeOut)
    }
    var body: some View {
        NavigationView {
            if #available(iOS 14.0, *) {
                list
                    .listStyle(InsetGroupedListStyle())
                    .navigationTitle("Favorites")
            } else {
                // Fallback on earlier versions
                list
                    .listStyle(GroupedListStyle())
                    .navigationBarTitle("Favorites")
            }
        }
        .accentColor(.init("Theme1"))
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
