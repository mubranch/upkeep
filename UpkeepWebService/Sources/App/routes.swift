import Vapor

func routes(_ app: Application) throws {
    app.get { _ async in
        "It works!"
    }

    app.get("test") { _ async -> String in
        """
            {
                "name":"KitchenAid KRFF577KPS",
                "type":"refrigerator",
                "brand":"KitchenAid",
                "modelNumber":"KRFF577KPS"
            }
        """
    }
}
