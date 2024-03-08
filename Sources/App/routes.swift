import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async throws in
        try await req.view.render("index", ["title": "Hello Vapor!"])
    }

    /// GET API
    app.get("json", ":name") { req async throws -> UserResponse in
        let name = try req.parameters.require("name")
        let message = "Hello, \(name.capitalized)!"
        return UserResponse(message: message)
    }
    
    /// POST API
    app.post("user-info") { req async throws -> UserResponse in
        let userInfo = try req.content.decode(UserInfo.self)
        
        let message = "Hello, \(userInfo.name.capitalized)! You are \(userInfo.age) years old."
        
        return UserResponse(message: message)
    }

    try app.register(collection: TodoController())
}

// MARK: models 
struct UserResponse: Content {
    let message: String
}

struct UserInfo: Content {
    let name: String
    let age: Int
}
