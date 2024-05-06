//
//  WebController.swift
//  Upkeep
//
//  Created by Mustafa on 5/2/24.
//

import Foundation
import SwiftData
import SwiftUI

// "Return only a JSON response for the given appliance: KitchenAid KRFF577KPS. The JSON should contain properties: name, type (in camelCase), brand (camelCase without punctuation), and modelNumber."

struct ApplianceDecodable {
    var name: String
    var categoryTitle: String
    var brandName: String
    var modelNumber: String
}

struct WebManager {
    @Environment(\.webServiceEndpoint) var endpoint

    var modelContext: ModelContext

    var categories: [Category] {
        fetchEntities()
    }

    var brands: [Brand] {
        fetchEntities()
    }

    func fetchAppliance(brand: Brand, modelNumber: String) async -> Appliance? {
        do {
            guard let url = URL(string: endpoint + "/\(brand.name)/\(modelNumber)") else {
                throw URLError(.badURL)
            }

            let (data, response) = try await URLSession.shared.data(from: url)

            guard let httpResponse = response as? HTTPURLResponse, (200 ... 299).contains(httpResponse.statusCode) else {
                throw NSError(domain: "HTTP Error", code: (response as? HTTPURLResponse)?.statusCode ?? -1, userInfo: nil)
            }

            let decodableRepresentation = try decodeResponse(for: data)
            let category: Category = checkForCategory(with: decodableRepresentation.categoryTitle)
            let brand: Brand = checkForBrand(with: decodableRepresentation.brandName)

            let appliance = Appliance(name: decodableRepresentation.name,
                                      category: category,
                                      brand: brand,
                                      modelNumber: decodableRepresentation.modelNumber)

            modelContext.insert(appliance)

            return appliance

        } catch {
            print(error)
            return nil
        }
    }

    func fetchApplianceTest() -> Appliance? {
        let json = """
            {
                "name":"KitchenAid KRFF507HPS",
                "category":"refrigerator",
                "brand":"KitchenAid",
                "modelNumber":"KRFF507HPS"
            }
        """

        do {
            guard let data = json.data(using: .utf8) else {
                throw NSError(domain: "JSON Error", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to convert JSON string to data"])
            }

            let decodableRepresentation = try decodeResponse(for: data)
            let category: Category = checkForCategory(with: decodableRepresentation.categoryTitle)
            let brand: Brand = checkForBrand(with: decodableRepresentation.brandName)

            let appliance = Appliance(name: decodableRepresentation.name,
                                      category: category,
                                      brand: brand,
                                      modelNumber: decodableRepresentation.modelNumber)

            modelContext.insert(appliance)

            return appliance

        } catch {
            print(error)
            return nil
        }
    }

    func fetchEntities<T: PersistentModel>() -> [T] {
        let fetchRequest = FetchDescriptor<T>()
        return (try? modelContext.fetch(fetchRequest)) ?? []
    }

    func decodeResponse(for data: Data) throws -> ApplianceDecodable {
        guard let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            throw NSError(domain: "InvalidData", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid JSON data"])
        }

        // Decode each key individually
        let name: String = try decodeKey(key: "name", json: jsonObject)
        let categoryTitle: String = try decodeKey(key: "category", json: jsonObject)
        let brandName: String = try decodeKey(key: "brand", json: jsonObject)
        let modelNumber: String = try decodeKey(key: "modelNumber", json: jsonObject)
        return ApplianceDecodable(name: name, categoryTitle: categoryTitle, brandName: brandName, modelNumber: modelNumber)
    }

    func decodeKey<T>(key: String, json: [String: Any]) throws -> T {
        guard let result = json[key] as? T else {
            throw NSError(domain: "MissingData", code: 0, userInfo: [NSLocalizedDescriptionKey: "Missing '\(key)' key"])
        }
        return result
    }

    func checkForCategory(with title: String) -> Category {
        return {
            let results = self.categories.filter {
                let existIngCategory = $0.rawValue.camelCase() == title.camelCase()
                if existIngCategory {
                    print("Category exists")
                    return true
                } else {
                    return false
                }
            }

            if !results.isEmpty {
                return results.first!
            } else {
                let category = Category(title: title)
                self.modelContext.insert(category)
                return category
            }
        }()
    }

    func checkForBrand(with name: String) -> Brand {
        return {
            let results = self.brands.filter {
                $0.rawValue.camelCase().lowercased() == name.camelCase().lowercased()
            }

            if !results.isEmpty {
                return results.first!
            } else {
                let brand = Brand(name: name)
                self.modelContext.insert(brand)
                return brand
            }
        }()
    }
}
