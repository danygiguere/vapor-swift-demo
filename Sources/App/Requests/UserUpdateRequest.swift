import Vapor

extension Request {
    struct UserUpdateRequest: Content, Validatable {
        
        let username: String
        
        static func validations(_ validations: inout Validations) {
            validations.add("username",
                            as: String.self,
                            is: .alphanumeric && .count(3...))
        }
        
        static func validate(req: Request) async throws -> User {
            guard let user = try await User.query(on: req.db).filter(.id, .equal, req.parameters.get("userID", as: UUID.self)).first() else {
                    throw Abort(.notFound)
            }
            // calling the built in validate method with content
            try Request.UserUpdateRequest.validate(content: req)
            let body = try req.content.decode(Request.UserUpdateRequest.self)
            user.username = body.username
            return user
        }
    }
}
