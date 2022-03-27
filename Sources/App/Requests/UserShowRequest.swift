import Vapor

extension Request {
    struct UserShowRequest: Content {
        
        static func validate(req: Request) async throws -> User {
            guard let user = try await User.query(on: req.db).filter(.id, .equal, req.parameters.get("userID", as: UUID.self) ).with(\.$posts).first() else {
                    throw Abort(.notFound)
            }
            return user
        }
    }
}

