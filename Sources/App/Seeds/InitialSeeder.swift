import FluentKit

struct InitialSeeder: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        
        let users: [User] = [
            .init(username: "johndoe"),
            .init(username: "janedoe"),
            .init(username: "someguy")
        ]
        
        let mapping = users.map { user in
            user.save(on: database)
        }
            .flatten(on: database.eventLoop)
        
        let posts: [Post] = [
            .init(title: "Title 1", user_id: users[0].id!),
            .init(title: "Title 2", user_id: users[0].id!),
            .init(title: "Title 3", user_id: users[1].id!),
            .init(title: "Title 4", user_id: users[2].id!)
        ]
        for post in posts {
            post.save(on: database)
        }
      
        return mapping
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        
        User.query(on: database).delete()
    }
}
