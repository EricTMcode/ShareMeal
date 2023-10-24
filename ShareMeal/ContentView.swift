//
//  ContentView.swift
//  ShareMeal
//
//  Created by Eric on 23/10/2023.
//

import SwiftUI

struct ContentView: View {
    @Environment(DataController.self) var dataController
    
    var body: some View {
        if let selectedFoodbank = dataController.selectedFoodbank {
            TabView {
                HomeView(foodbank: selectedFoodbank)
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                
                Text("My Foodbank")
                    .tabItem {
                        Label("My Foodbank", systemImage: "building.2")
                    }
                DropOffView(foodbank: selectedFoodbank)
                    .tabItem {
                        Label("Drop-off Points", systemImage: "basket")
                    }
            }
        } else {
            EnterLocationView()
        }
    }
}

#Preview {
    ContentView()
}
