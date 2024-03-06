import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async throws in
        try await req.view.render("index", ["title": "Hello Vapor!"])
    }

    app.get("hello", ":name") { req async throws -> String in
        let name = try req.parameters.require("name")
        return "Hello, \(name.capitalized)!"
    }

    try app.register(collection: TodoController())
}
