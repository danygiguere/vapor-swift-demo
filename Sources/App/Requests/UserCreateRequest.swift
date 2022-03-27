import Vapor

extension Request {
    struct UserCreateRequest: Content, Validatable {
        
        let username: String
        
        static func validations(_ validations: inout Validations) {
            validations.add("username",
                            as: String.self,
                            is: .alphanumeric && .count(3...))
        }
        
        static func validate(req: Request) throws -> User {
            // calling the built in validate method with content
            try Request.UserCreateRequest.validate(content: req)
            let body = try req.content.decode(Request.UserCreateRequest.self)
            let user = User()
            user.username = body.username
            return user
        }
    }
}
