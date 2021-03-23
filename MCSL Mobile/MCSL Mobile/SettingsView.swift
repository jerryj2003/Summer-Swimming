//
//  SettingsView.swift
//  MCSL Mobile
//
//  Created by Jerry Ji on 1/20/21.
//  Copyright © 2021 Jerry Ji. All rights reserved.
//

import SwiftUI
import Combine

struct SettingsView: View {
    
    @ObservedObject
    var manager = SettingsManager.shared
    
    var content: some View {
        List{
            Section(header: Text("Year Selector")){
                Picker(selection: $manager.selectedYear, label: Text("Year Selector")) {
                    ForEach(manager.years, id:\.self){ year in
                        Text(year)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .onReceive(Just(manager.selectedYear), perform: { yearIndex in
                    manager.update()
                })
            }
            Section(header: Text("miscellaneous")){
                NavigationLink(
                    destination: IconsView(),
                    label: {
                        HStack{
                            Image(systemName: "wand.and.stars")
                                .foregroundColor(.accentColor)
                            Text("Alternative Icons")
                        }
                    })
            }
        }
    }
    
    var body: some View {
        NavigationView {
            if #available(iOS 14.0, *) {
                ZStack{
                    Color.init(.systemGroupedBackground)
                        .ignoresSafeArea(.all)
                    content
                        .listStyle(InsetGroupedListStyle())
                        .navigationTitle("Settings")
                }
            } else {
                // Fallback on earlier versions
                ZStack{
                    Color.init(.systemGroupedBackground)
                        .edgesIgnoringSafeArea(.all)
                    content
                        .listStyle(GroupedListStyle())
                        .navigationBarTitle("Settings")
                }
            }
        }
        .accentColor(.init("Theme1"))
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
