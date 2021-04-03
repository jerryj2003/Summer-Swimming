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
    var sManager = SettingsManager.shared
    @ObservedObject
    var manager = FavoritesManager.shared
    @State
    var isStarFilled = true
    @State
    var unstarredID : String? = nil
    
    var nonEmptyList : some View{
        List{
            ForEach(manager.favoriteIDs, id:\.self){ id in
                NavigationLink(destination: MemberView(id:id, name: manager.swimmer(for: id, year: sManager.selectedYear)?.name ?? "")) {
                    HStack{
                        if isStarFilled || id != unstarredID{
                            Image(systemName: "star.fill")
                                .foregroundColor(.accentColor)
                                .onTapGesture {
                                    isStarFilled = false
                                    unstarredID = id
                                    Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (_) in
                                        withAnimation {
                                            unstarredID = nil
                                            manager.invert(ID: id)
                                        }
                                    }
                                }
                        }else{
                            Image(systemName: "star")
                                .foregroundColor(.accentColor)
                            
                        }
                        VStack(alignment:.leading){
                            if let swimmer = manager.swimmer(for: id, year: sManager.selectedYear) {
                                Text(swimmer.name)
                            } else {
                                Text("Loading...")
                            }
                            
                            if let swimmer = manager.swimmer(for: id, year: sManager.selectedYear) {
                                if swimmer.age != nil{
                                    Text("\(swimmer.team) | \(swimmer.age!)")
                                        .font(.caption)
                                } else {
                                    Text("")
                                        .font(.caption)
                                }
                            } else {
                                Text("")
                                    .font(.caption)
                                
                            }
                        }
                    }
                }
            }
        }
        .animation(.easeOut)
        .transition(.slide)
    }
    
    var list: some View {
        Group{
            if manager.favoriteIDs.isEmpty{
                Text("No Favorites Added")
                    .font(.system(.largeTitle, design: .default))
                    .foregroundColor(.init(.secondary))
                    .transition(.slide)
            }else{
                nonEmptyList
            }
        }
    }
    var body: some View {
        NavigationView {
            if #available(iOS 14.0, *) {
                ZStack{
                    Color.init(.systemGroupedBackground)
                        .ignoresSafeArea()
                    list
                        .listStyle(InsetGroupedListStyle())
                        .navigationTitle("Favorites")
                }
            } else {
                // Fallback on earlier versions
                ZStack{
                    Color.init(.systemGroupedBackground)
                        .edgesIgnoringSafeArea(.all)
                    list
                        .listStyle(GroupedListStyle())
                        .navigationBarTitle("Favorites")
                }
            }
        }
        .accentColor(.init("Theme1"))
    }
}

struct FavoritesView_Previews: PreviewProvider {
    
    static let manager: FavoritesManager = {
        let manager = FavoritesManager.shared
        let favoriteIDs = [
            "e70438eb7f13cfdb981e59eee47435af8824d9012610b6aacf4414b4",
            "e70e26d95626b34022756eafbdde2d9de026a2d59298da6148e3981d",
            "e71379e4b5d6f95e65c3834b3b9dbf13d6d8f5c7d30b183d72e17ad6"
        ]
        for id in favoriteIDs {
            if !manager.checkFavorites(ID: id){
                manager.add(ID: id)
            }
        }
        return manager
    }()
    
    static var previews: some View {
        FavoritesView(manager: manager)
    }
}
