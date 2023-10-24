//
//  DataController.swift
//  ShareMeal
//
//  Created by Eric on 23/10/2023.
//

import Foundation

enum loadState {
    case loading, failed, loaded([FoodBank])
}

@Observable
class DataController {
    private(set) var selectedFoodbank: FoodBank?
    
    private let savePath = URL.documentsDirectory.appending(path: "SelectedFoodBank")
    
    init() {
        do {
            let data = try Data(contentsOf: savePath)
            let savedFoodbank = try JSONDecoder().decode(FoodBank.self, from: data)
            select(savedFoodbank)
        } catch {
            
        }
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(selectedFoodbank)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save data")
        }
    }
    
    func loadFoodbanks(near postCode: String) async -> loadState {
        let fullURL = "https://www.givefood.org.uk/api/2/foodbanks/search/?address=\(postCode)"
        
        guard let url = URL(string: fullURL) else {
            return .failed
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let foodbanks = try JSONDecoder().decode([FoodBank].self, from: data)
            return .loaded(foodbanks)
        } catch {
            return .failed
        }
    }
    
    func select(_ foodbank: FoodBank?) {
        selectedFoodbank = foodbank
        save()
        
        Task {
            await updateSelected()
        }
    }
    
    private func updateSelected() async {
        guard let current = selectedFoodbank else { return }
        
        let fullURL = "https://www.givefood.org.uk/api/2/foodbank/\(current.slug)"
        
        guard let url = URL(string: fullURL) else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            selectedFoodbank = try JSONDecoder().decode(FoodBank.self, from: data)
        } catch {
            print("Failed to update food bank: \(error.localizedDescription)")
        }
    }
}
