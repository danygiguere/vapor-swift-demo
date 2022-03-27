# README

### About
- This is just a demo app to get started with [https://vapor.codes/](https://vapor.codes/) a back-end framework built with Swift
- Vapor 4's Alpha 1 Release started in May 2019 and the stable version released in April 2020. `https://en.wikipedia.org/wiki/Vapor_(web_framework)`

### Documentation
- [https://vapor.codes/](https://vapor.codes/)
- [https://api.vapor.codes](https://api.vapor.codes)
- [https://www.raywenderlich.com/library?q=vapor%204&sort_order=relevance](https://www.raywenderlich.com/library?q=vapor%204&sort_order=relevance)
- [https://github.com/vapor/vapor/](https://github.com/vapor/vapor/)
- [https://github.com/vapor-community/awesome-vapor](https://github.com/vapor-community/awesome-vapor)
- [https://theswiftdev.com](https://theswiftdev.com)
- [https://www.willowtreeapps.com/craft/swift-and-kotlin-the-subtle-differences](https://www.willowtreeapps.com/craft/swift-and-kotlin-the-subtle-differences)

### Notes
- To change the swift (Swift tools) version on your mac, go to xcode/preferences/locations and change the version under Command Line Tools
- In order to make the project root folders and files (like the .env.development) available to Vapor, you must change the Custom Working Directory here : `https://docs.vapor.codes/4.0/xcode/#custom-working-directory`
- To view all the routes in your project do: `vapor run routes`
- If you get an error that says the port 8080 is already taken, do `lsof -i:8080`, take the pid and then run `kill -9 pidNumber`
- You can create a database by running : `docker-compose up db`
- don't forget to set the db to `tls.certificateVerification = .none` locally `https://docs.vapor.codes/4.0/fluent/overview/#mysql`

### Installation
- Requirements: Xcode 13, MacOS Monterrey, Swift 5.5
- `cp .env .env.development`
- `vim .env.development`
- For testing, create a new db and a .env.testing file.


### Commands
- swift run Run migrate
- swift run Run migrate --auto-migrate
- swift run Run migrate --revert
- vapor run routes


### Demo requirements
#### Completed
- create User and Post models and controllers
- create db migrations
- create `user has many posts` relationship
- create db seeds
- install i18n
- create DemoController

#### todo
- creat validation for the post model (POST request) https://www.raywenderlich.com/books/server-side-swift-with-vapor/v3.0/chapters/21-validation
- for the validation, make sure we can create custom messages (and translate them)
- create a middleware (maybe a language detector that sets the language)
- install JWT
- Implement WebSockets
- Figure out how to remove the "Run would like to access files in your Documents folder." message
- Convert migrations and seeds to async await


#### todo (nice to have)
- split the DataSeeder file in multiple files  
