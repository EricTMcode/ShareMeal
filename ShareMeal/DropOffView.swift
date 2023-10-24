//
//  DropOffView.swift
//  ShareMeal
//
//  Created by Eric on 24/10/2023.
//

import MapKit
import SwiftUI

struct DropOffView: View {
    var foodbank: FoodBank
        
    var body: some View {
        NavigationStack {
            Map {
                if let coordinate = foodbank.coordinate {
                    Marker("Your foodbank", coordinate: coordinate)
                }
                
                if let locations = foodbank.locations {
                    ForEach(locations) { location in
                        if let coordinate = location.coordinate {
                            Marker(location.name, coordinate: coordinate)
                        }
                    }
                }
            }
            .navigationTitle("Drop-off Points")
        }
    }
}

#Preview {
    DropOffView(foodbank: .example)
}
