//
//  ShareMealApp.swift
//  ShareMeal
//
//  Created by Eric on 23/10/2023.
//

import SwiftUI

@main
struct ShareMealApp: App {
    @State private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(dataController)
        }
    }
}
