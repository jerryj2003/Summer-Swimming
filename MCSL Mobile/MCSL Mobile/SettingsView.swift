//
//  SettingsView.swift
//  MCSL Mobile
//
//  Created by Jerry Ji on 1/20/21.
//  Copyright © 2021 Jerry Ji. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    
    var years = ["2019","2018","2017","2016","2015"]
    @State
    var yearIndex = UserDefaults.standard.integer(forKey: "yearIndex") {
        didSet{
            UserDefaults.standard.set(yearIndex, forKey: "yearIndex")
        }
    }
    
    var content: some View {
        List{
            Section(header: Text("Year Selector")){
                Picker(selection: $yearIndex, label: Text("Year Selector")) {
                    ForEach(years, id: \.self){ year in
                        Text(year)
                    }
                }
                .pickerStyle(WheelPickerStyle())
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
