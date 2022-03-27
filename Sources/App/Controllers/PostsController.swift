import Fluent
import Vapor

struct PostsController {

    func create(req: Request) async throws -> Post {
        let post = try req.content.decode(Post.self)
        try await post.save(on: req.db)
        return post
    }
    
    func delete(req: Request) async throws -> HTTPStatus {
        try await Post.query(on: req.db).filter(.id, .equal, req.parameters.get("postID", as: UUID.self) ).delete()
        return HTTPStatus.ok
    }
}
