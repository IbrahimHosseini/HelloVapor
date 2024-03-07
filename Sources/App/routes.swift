import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async throws in
        try await req.view.render("index", ["title": "Hello Vapor!"])
    }

    app.get("json", ":name") { req async throws -> UserResponse in
        let name = try req.parameters.require("name")
        let message = "Hello, \(name.capitalized)!"
        return UserResponse(message: message)
    }

    try app.register(collection: TodoController())
}

struct UserResponse: Content {
    let message: String
}
