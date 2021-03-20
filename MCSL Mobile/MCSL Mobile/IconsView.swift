//
//  IconsView.swift
//  MCSL Mobile
//
//  Created by Jerry Ji on 1/23/21.
//  Copyright © 2021 Jerry Ji. All rights reserved.
//

import SwiftUI

struct IconsView: View {
    
    var icons : [Icon] = [
        Icon(fileName: "classic@3x.png", displayName: "Classic", identifierName: nil),
        Icon(fileName: "beach@3x.png", displayName: "Beach", identifierName: "beach"),
        Icon(fileName: "luminous@3x.png", displayName: "Twilight", identifierName: "luminous"),
        Icon(fileName: "midnight@3x.png", displayName: "Shining Night", identifierName: "midnight"),
        Icon(fileName: "galaxy@3x.png", displayName: "Deep Space", identifierName: "galaxy"),
        Icon(fileName: "dark@3x.png", displayName: "Dark", identifierName: "dark"),
        Icon(fileName: "light@3x.png", displayName: "Light", identifierName: "light")
    ]
    
    var content: some View {
        List{
            ForEach(icons){ icon in
                HStack{
                    Image(uiImage: UIImage(named: icon.fileName)!)
                        .resizable()
                        .frame(width: 60, height: 60)
                        .cornerRadius(10)
                    Text(icon.displayName)
                }
                .onTapGesture {
                    UIApplication.shared.setAlternateIconName(icon.identifierName)
                }
            }
        }
    }
    
    var body: some View {
            if #available(iOS 14.0, *) {
                ZStack{
                    Color.init(.systemGroupedBackground)
                        .ignoresSafeArea()
                    content
                        .listStyle(InsetGroupedListStyle())
                        .navigationTitle("Icons")
                }
            } else {
                // Fallback on earlier versions
                ZStack{
                    Color.init(.systemGroupedBackground)
                        .edgesIgnoringSafeArea(.all)
                    content
                        .listStyle(GroupedListStyle())
                        .navigationBarTitle("Icons")
                }
            }
    }
}

struct IconsView_Previews: PreviewProvider {
    static var previews: some View {
        IconsView()
    }
}
