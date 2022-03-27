@testable import App
import Fluent

extension User {
  static func create(
    username: String,
    on database: Database
  ) throws -> User {
    let user = User(username: username)
    try user.save(on: database).wait()
    return user
  }
}
