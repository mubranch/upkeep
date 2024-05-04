
import Vapor

func routes(_ app: Application) throws {
    app.get { _ async in
        "Welcome to the upkeep webservice"
    }

    app.get(":brand", ":modelNumber") { req async throws -> String in

        guard let brand = req.parameters.get("brand") else {
            throw Abort(.badRequest)
        }

        guard let modelNumber = req.parameters.get("modelNumber") else {
            throw Abort(.badRequest)
        }

        let service = OpenAIService()
        let result = try await service.fetchApplianceJSON(brand: brand, modelNumber: modelNumber)
        return result
    }
}
