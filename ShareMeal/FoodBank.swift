//
//  FoodBank.swift
//  ShareMeal
//
//  Created by Eric on 23/10/2023.
//

import CoreLocation
import Foundation

struct FoodBank: Codable, Identifiable {
    var id: String { slug }
    var name: String
    var slug: String
    var phone: String
    var email: String
    var address: String
    var distance: Int?
    var location: String
    var items: Items?
    var alternativeItems: Items?
    var locations: [Location]?
    
    var distanceFormatted: String {
        guard let distance else {
            return "Unknown distance from you"
        }
        
        let measurement = Measurement(value: Double(distance), unit: UnitLength.meters)
        let measurementString = measurement.formatted(.measurement(width: .wide))
        return "\(measurementString) from you"
    }
    
    enum CodingKeys: String, CodingKey {
        case name, slug, phone, email, address, distance = "distance_m", location = "lat_lng", items = "needs", alternativeItems = "need", locations
    }
    
    var actuelItems: Items {
        items ?? alternativeItems ?? Items(id: "None", needs: "None")
    }
    
    var neededItems: [String] {
        let baseList = actuelItems.needs.components(separatedBy: .newlines)
        return Set(baseList).sorted()
    }
    
    var coordinate: CLLocationCoordinate2D? {
        let components = location.split(separator: ",").compactMap(Double.init)
        guard components.count == 2 else { return nil }
        
        return CLLocationCoordinate2D(latitude: components[0], longitude: components[1])
    }
    
    static let example = FoodBank(name: "Example Name", slug: "Example Slug", phone: "Example Phone", email: "Example Email", address: "Example Adress", distance: 1000, location: "0,0", items: .example)
}

extension FoodBank {
    struct Items: Codable, Identifiable {
        var id: String
        var needs: String
        var excess: String?
        
        static let example = Items(id: "Example ID", needs: "Example Needed Item", excess: "Example Excess Item")
    }
}

struct Location: Codable, Identifiable {
    enum CodingKeys: String, CodingKey {
        case name, slug, address, location = "lat_lng"
    }
    var id: String { slug }
    var name: String
    var slug: String
    var address: String
    var location: String
    
    var coordinate: CLLocationCoordinate2D? {
        let components = location.split(separator: ",").compactMap(Double.init)
        guard components.count == 2 else { return nil }
        
        return CLLocationCoordinate2D(latitude: components[0], longitude: components[1])
    }
}
