//
//  File.swift
//
//
//  Created by Mustafa on 5/2/24.
//

import Foundation
import OpenAI

struct OpenAIService {
    static var apiKey: String? {
        guard let key = ProcessInfo.processInfo.environment["API_KEY"] else {
            return nil
        }
        return key
    }

    var openAI = OpenAI(apiToken: apiKey ?? "")

    func fetchApplianceJSON(brand: String, modelNumber: String) async throws -> String {
        guard brand.count < 20, modelNumber.count < 20 else {
            return "{ \"error\": \"Invalid paramter for brand or modelNumber\"}"
        }

        let prompt = "You are an expert on appliances. A user is giving you an appliance brand and a modelNumber. Your job is to figure out which appliance they are looking for. Return only a JSON response for that appliance. The JSON should contain properties: name, category (in camelCase e.g. KitchenAid is kitchenaid), brand (camelCase without punctuation), and modelNumber. Types should be the basic appliance type without qualifiers. Titles should include the brand name, and appliance type. Here is the brand and modelNumber: \(brand) \(modelNumber) for the appliance they are looking for."

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
