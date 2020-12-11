//
//  MemberView.swift
//  MCSL Mobile
//
//  Created by Jerry Ji on 12/6/20.
//  Copyright © 2020 Jerry Ji. All rights reserved.
//

import SwiftUI
import UIKit

struct MemberView : View {
    @ObservedObject
    var manager = FavoritesManager.shared
    
    let id : String
    let name : String
    var list: some View{
        MemberUIView(id:id)
            .navigationBarItems(trailing: Button(action: {manager.invert(ID: id)}) {
                if manager.checkFavorites(ID: id){
                    Image.init(systemName: "star.fill")
                } else {
                    Image.init(systemName: "star")
                    
                }
            })
    }
   
    var body: some View {
        NavigationView {
            if #available(iOS 14.0, *) {
                list
                    .navigationTitle(name)
                    .ignoresSafeArea(.all)
            } else {
                // Fallback on earlier versions
                list
                    .navigationBarTitle(name)
                    .edgesIgnoringSafeArea(.all)
            }
        }
        .accentColor(.init("Theme1"))
    }
}

struct MemberUIView: UIViewControllerRepresentable {
    let id : String
    
    func makeUIViewController(context: Context) -> MemberTableViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MemberTableViewController") as! MemberTableViewController
        vc.id = id
        return vc
    }
    func updateUIViewController(_ uiViewController: MemberTableViewController, context: Context) {
        //No update needed
    }
}

struct MemberView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            MemberView(id:"e70438eb7f13cfdb981e59eee47435af8824d9012610b6aacf4414b4",
                       name: "whatever")
        }
    }
}
