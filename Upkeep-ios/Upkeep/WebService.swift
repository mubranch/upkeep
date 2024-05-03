//
//  WebService.swift
//  Upkeep
//
//  Created by Mustafa on 5/2/24.
//

import Foundation

// "Return only a JSON response for the given appliance: KitchenAid KRFF577KPS. The JSON should contain properties: name, type (in camelCase), brand (camelCase without punctuation), and modelNumber."

struct WebServiceCodable: Codable {
    var name: String
    var type: ApplianceType
    var brand: ApplianceBrand
    var modelNumber: String
}

extension WebServiceCodable {
    func convertToAppliance() -> Appliance {
        Appliance(name: self.name, type: self.type, brand: self.brand, modelNumber: self.modelNumber)
    }
}

enum WebService {
    @MainActor
    static func fetchAppliance(brand: ApplianceBrand, modelNumber: String) async throws -> Appliance {
        guard let url = URL(string: "Some URL") else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, (200 ... 299).contains(httpResponse.statusCode) else {
            throw NSError(domain: "HTTP Error", code: (response as? HTTPURLResponse)?.statusCode ?? -1, userInfo: nil)
        }

        do {
            let decodedData = try JSONDecoder().decode(WebServiceCodable.self, from: data)
            return decodedData.convertToAppliance()
        } catch {
            throw error
        }
    }

    @MainActor
    static func fetchApplianceTest() async throws -> Appliance {
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
