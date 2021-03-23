//
//  SettingsManager.swift
//  MCSL Mobile
//
//  Created by Jerry Ji on 3/23/21.
//  Copyright © 2021 Jerry Ji. All rights reserved.
//

import Foundation

class SettingsManager: ObservableObject {
    
    //    Makes it so it allows for SettingsManager to be refrenced in other places
    static let shared = SettingsManager()
    
    //  Create an array of all years since 2015
    var years = ["2020","2019","2018","2017","2016","2015"]
    
    //  Pass in selected year
    @Published
    var selectedYear : String
    private init(){
        let savedYear = UserDefaults.standard.string(forKey: "savedYear")
        selectedYear = savedYear ?? "2019"
    }
    
    //Update the year that the user selects
    func selectYear(year: String){
        selectedYear = year
        update()
    }
    
    //  Save the selected year to User Defaults
    func update() {
        let defaults = UserDefaults.standard
        defaults.set(selectedYear, forKey: "savedYear")
    }
}
