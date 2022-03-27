import Fluent
import Vapor

struct UsersController {
    
    func index(req: Request) async throws ->[User] {
        return try await User.query(on: req.db).with(\.$posts).all()
    }
    
    func show(req: Request) async throws -> User {
        let user = try await Request.UserShowRequest.validate(req: req)
        return user
    }

    func create(req: Request) async throws -> User {
        let user = try Request.UserCreateRequest.validate(req: req)
        try await user.create(on: req.db)
        return user
    }
    
    func update(req: Request) async throws -> User {
        let user = try await Request.UserUpdateRequest.validate(req: req)
        try await user.update(on: req.db)
        return user
    }

    func delete(req: Request) async throws -> HTTPStatus {
        try await User.query(on: req.db).filter(.id, .equal, req.parameters.get("userID", as: UUID.self) ).delete()
        return HTTPStatus.ok
    }
}
