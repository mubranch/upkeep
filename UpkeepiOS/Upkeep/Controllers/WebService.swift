//
//  WebService.swift
//  Upkeep
//
//  Created by Mustafa on 5/2/24.
//

import Foundation
import SwiftData
import SwiftUI

// "Return only a JSON response for the given appliance: KitchenAid KRFF577KPS. The JSON should contain properties: name, type (in camelCase), brand (camelCase without punctuation), and modelNumber."

struct WebServiceCodable: Codable {
    var name: String
    var category: Category
    var brand: Brand
    var modelNumber: String
}

extension WebServiceCodable {
    func convertToAppliance() -> Appliance {
        Appliance(name: self.name, category: self.category, brand: self.brand, modelNumber: self.modelNumber)
    }
}

struct WebService {
    @Environment(\.webServiceEndpoint) var endpoint
    var modelContext: ModelContext

    var categories: [Category] {
        let fetchRequest = FetchDescriptor<Category>()
        return (try? self.modelContext.fetch(fetchRequest)) ?? []
    }

    var brands: [Brand] {
        let fetchRequest = FetchDescriptor<Brand>()
        return (try? self.modelContext.fetch(fetchRequest)) ?? []
    }

    @MainActor
    func fetchAppliance(brand: Brand, modelNumber: String) async throws -> Appliance {
        print("Starting search")
        guard let url = URL(string: endpoint + "/\(brand.name)/\(modelNumber)") else {
            print("Bad URL")
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, (200 ... 299).contains(httpResponse.statusCode) else {
            print("HTTP ERROR")
            throw NSError(domain: "HTTP Error", code: (response as? HTTPURLResponse)?.statusCode ?? -1, userInfo: nil)
        }

        do {
            guard let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                print("Invalid Data")
                throw NSError(domain: "InvalidData", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid JSON data"])
            }

            print(jsonObject)

            // Decode each key individually
            guard let name = jsonObject["name"] as? String else {
                print("Missing Data")
                throw NSError(domain: "MissingData", code: 0, userInfo: [NSLocalizedDescriptionKey: "Missing 'name' key"])
            }

            guard let categoryTitle = jsonObject["type"] as? String else {
                print("Missing Data")
                throw NSError(domain: "MissingData", code: 0, userInfo: [NSLocalizedDescriptionKey: "Missing 'type' key"])
            }

            let category: Category = {
                let results = self.categories.filter {
                    $0.rawValue.camelCase() == categoryTitle.camelCase()
                }
                if !results.isEmpty {
                    return results.first!
                } else {
                    return Category(title: categoryTitle)
                }
            }()

            guard let brandName = jsonObject["brand"] as? String else {
                print("Missing Data")
                throw NSError(domain: "MissingData", code: 0, userInfo: [NSLocalizedDescriptionKey: "Missing 'brand' key"])
            }

            let brand: Brand = {
                let results = self.brands.filter {
                    $0.rawValue.camelCase() == brandName.camelCase()
                }
                if !results.isEmpty {
                    return results.first!
                } else {
                    return Brand(name: brandName)
                }
            }()

            guard let modelNumber = jsonObject["modelNumber"] as? String else {
                print("Missing Data")
                throw NSError(domain: "MissingData", code: 0, userInfo: [NSLocalizedDescriptionKey: "Missing 'modelNumber' key"])
            }

            self.modelContext.insert(category)
            self.modelContext.insert(brand)

            let appliance = Appliance(name: name, category: category, brand: brand, modelNumber: modelNumber)

            self.modelContext.insert(appliance)

            return appliance

        } catch {
            throw error
        }
    }

    @MainActor
    func fetchApplianceTest() async throws -> Appliance {
        let json = """
            {
                "name":"KitchenAid KRFF577KPS",
                "type":"refrigerator",
                "brand":"KitchenAid",
                "modelNumber":"KRFF577KPS"
            }
        """

        guard let jsonData = json.data(using: .utf8) else {
            throw NSError(domain: "JSON Error", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to convert JSON string to data"])
        }

        do {
            let decodedData = try JSONDecoder().decode(WebServiceCodable.self, from: jsonData)
            return decodedData.convertToAppliance()
        } catch {
            throw error
        }
    }
}
