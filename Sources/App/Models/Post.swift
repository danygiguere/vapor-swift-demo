import Fluent
import Vapor

final class Post: Model, Content {
    static let schema = "posts"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "title")
    var title: String
    
    @Parent(key: "user_id")
    var user: User

    init() { }

    init(id: UUID? = nil, title: String, user_id: UUID) {
        self.id = id
        self.title = title
        self.$user.id = user_id
    }
}
