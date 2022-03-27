import Fluent
import Vapor

func routes(_ app: Application) throws {
    let demoController = DemoController()
    let usersController = UsersController()
    let postsController = PostsController()

    app.get("", use: demoController.index)
    app.get("demo", "joins", use: demoController.joins)
    app.get("demo", "raw-query", use: demoController.rawQuery)
    app.post("demo", "db-transaction", use: demoController.dbTransaction)
    app.get("demo", "logger", use: demoController.logger)
    app.post("demo", "custom-validation", use: demoController.customValidation)
    
    app.get("users", use: usersController.index)
    app.get("users",":userID", use: usersController.show)
    app.post("users", use: usersController.create)
    app.put("users",":userID", use: usersController.update)
    app.delete("users",":userID", use: usersController.delete)
    
    app.post("posts", use: postsController.create)
    app.delete("posts",":postID", use: postsController.delete)
}
