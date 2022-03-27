@testable import App
import XCTVapor

final class DemoTests: XCTestCase {
    func testHomePage() throws {
        let app = Application(.testing)
        defer { app.shutdown() }
        try configure(app)

        try app.test(.GET, "", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.body.string, "Hello world!")
        })
    }
}
