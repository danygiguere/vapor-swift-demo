@testable import App
import XCTVapor

final class UserTests: XCTestCase {
    
    let johndoe = "johndoe"
    let janedoe = "janedoe"
    let usersURI = "/users/"
    var app: Application!
    
    override func setUpWithError() throws {
        app = try Application.testable()
    }
    
    override func tearDownWithError() throws {
        app.shutdown()
    }
    
    func testCanGetAllUsers() throws {
        try User.create(
            username: johndoe,
            on: app.db)
        try User.create(
            username: janedoe,
            on: app.db)
        
        try app.test(.GET, usersURI, afterResponse: { response in
            XCTAssertEqual(response.status, .ok)
            let users = try response.content.decode([User].self)
            XCTAssertEqual(users.count, 2)
        })
    }
    
    func testCanGetASingleUser() throws {
        let user = try User.create(
            username: janedoe,
            on: app.db)
        
        try app.test(.GET, "\(usersURI)\(user.id!)",
                     afterResponse: { response in
            let receivedUser = try response.content.decode(User.self)
            XCTAssertEqual(receivedUser.username, janedoe)
            XCTAssertEqual(receivedUser.id, user.id)
        })
    }
    
    func testCanCreateUser() throws {
        let user = User(username: janedoe)
        
        try app.test(.POST, usersURI, beforeRequest: { req in
            try req.content.encode(user)
        }, afterResponse: { response in
            let receivedUser = try response.content.decode(User.self)
            XCTAssertEqual(receivedUser.username, janedoe)
            XCTAssertNotNil(receivedUser.id)
        })
    }
    
    func testCanUpdateAUser() throws {
        let user = try User.create(
            username: janedoe,
            on: app.db)
        let updatedUser = User(username: johndoe)
        
        try app.test(.PUT, "\(usersURI)\(user.id!)", beforeRequest: { req in
            try req.content.encode(updatedUser)
        }, afterResponse: { response in
            let receivedUser = try response.content.decode(User.self)
            XCTAssertEqual(receivedUser.username, johndoe)
            XCTAssertNotNil(receivedUser.id)
        })
    }
    
    func testCanDeleteAUser() throws {
        let user = try User.create(
            username: janedoe,
            on: app.db)
        
        try app.test(.DELETE, "\(usersURI)\(user.id!)", afterResponse: { response in
            XCTAssertEqual(response.status, .ok)
        })
        try app.test(.GET, "\(usersURI)\(user.id!)",
                     afterResponse: { response in
            XCTAssertEqual(response.status, .notFound)
        })
    }
}
