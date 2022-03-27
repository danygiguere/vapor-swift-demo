import Fluent
import FluentMySQLDriver
import Vapor
import LingoVapor

// configures your application
public func configure(_ app: Application) throws {
    app.lingoVapor.configuration = .init(defaultLocale: "en", localizationsDir: "Localizations")
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    var tls = TLSConfiguration.makeClientConfiguration()
    tls.certificateVerification = .none
    app.databases.use(.mysql(
        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? MySQLConfiguration.ianaPortNumber,
        username: Environment.get("DATABASE_USERNAME") ?? "vapor_username",
        password: Environment.get("DATABASE_PASSWORD") ?? "vapor_password",
        database: Environment.get("DATABASE_NAME") ?? "vapor_database",
        tlsConfiguration: tls
    ), as: .mysql)

    // run migrations
    app.migrations.add(CreateUser())
    app.migrations.add(CreatePost())
    
    // run seeders if in development
    if app.environment == .development {
        app.migrations.add(InitialSeeder())
    }

    try app.autoMigrate().wait()
    
    // register routes
    try routes(app)
}
