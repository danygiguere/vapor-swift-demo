import Fluent
import Vapor
import FluentSQL

struct DemoController {
    
    func index(req: Request) async throws -> String {
        let lingo = try req.application.lingoVapor.lingo()
        return lingo.localize("hello_world", locale: "en")
    }
    
    func joins(req: Request) async throws -> User {
        return try await User.query(on: req.db)
            .join(Post.self, on: \User.$id == \Post.$user.$id)
            .filter(User.self, \.$username == "johndoe")
            .with(\.$posts)
            .first()!
    }
    
    func rawQuery(req: Request) async throws -> [User] {
        let sql = req.db as? SQLDatabase
        return try await sql!.raw("SELECT * FROM users").all(decoding: User.self)
    }
    
    func dbTransaction(req: Request) async throws -> String {
        try await req.db.transaction { transaction in
            let user = User(username: "jeffbezos")
            try await user.save(on: transaction)
            let post = Post(title: "New title from \(user.username)", user_id: user.id!)
            try await post.save(on: transaction)
            return "user \(user.username) with a post were created as one db transaction"
        }
    }
    
    func logger(req: Request) async throws -> String {
        req.logger.info("Demo req.url: \(req.url)")
        req.logger.info("Demo req.content: \(req.content)")
        req.logger.info("Demo req.body: \(req.body)")
        req.logger.info("Demo req: \(req)")
        return "logger demo"
    }
    
    func customValidation(req: Request) async throws -> String {
        let payload = try Request.CustomValidationRequest.validate(req: req)
        return payload
    }
}
