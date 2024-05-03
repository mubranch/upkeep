//
//  File.swift
//
//
//  Created by Mustafa on 5/2/24.
//

import Foundation
import OpenAI

final class OpenAIService {
    static var apiKey: String? {
        if let key = ProcessInfo.processInfo.environment["API_KEY"] {
            return key
        } else {
            return nil
        }
    }

    let openAI = OpenAI(apiToken: apiKey ?? "")

    func fetchApplianceJSON(brand: String, modelNumber: String) async throws -> String {
        guard brand.count < 20, modelNumber.count < 20 else {
            return "{ \"error\": \"Invalid paramter for brand or modelNumber\"}"
        }

        let prompt = "Return only a JSON response for the given appliance: \(brand) \(modelNumber). The JSON should contain properties: name, type (in camelCase e.g. KitchenAid is kitchenaid), brand (camelCase without punctuation), and modelNumber. Types should be the basic appliance type without qualifiers. Titles should include the brand name, and appliance type."

        let query = ChatQuery(messages: [.user(.init(content: .string(prompt)))],
                              model: .gpt4_turbo,
                              stream: false)

        let chat = try await openAI.chats(query: query)
        return "\(trimToBraces(chat.choices.first?.message.content?.string ?? "{\"error\": \"No choices found\"}"))"
    }

    func trimToBraces(_ input: String) -> String {
        guard let startRange = input.range(of: "{"),
              let endRange = input.range(of: "}", options: .backwards),
              startRange.upperBound < endRange.lowerBound
        else {
            return "{\"error\": \"No choices found\"}"
        }

        return "{ " + String(input[startRange.upperBound ..< endRange.lowerBound]) + " }"
    }
}
