//
//  HomeView.swift
//  ShareMeal
//
//  Created by Eric on 24/10/2023.
//

import SwiftUI

struct HomeView: View {
    @Environment(DataController.self) var dataController
    var foodbank: FoodBank
    
    var body: some View {
        NavigationStack {
            List {
                Section("\(foodbank.name) foodbank needs...") {
                    ForEach(foodbank.neededItems, id: \.self) { item in
                        Text(item)
                    }
                }
            }
            .navigationTitle("Share a meal")
            .toolbar {
                Button("Change Location") {
                    withAnimation {
                        dataController.select(nil)
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView(foodbank: .example)
}
