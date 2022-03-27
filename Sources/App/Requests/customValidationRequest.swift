import Vapor

extension Request {
    struct CustomValidationRequest: Content {
        
        let username: String

        static func validate(req: Request) throws -> String {
            
            let body = try req.content.decode(Request.CustomValidationRequest.self)

            if(body.username.count < 6) {
//                throw Abort.custom(.unprocessableEntity,
//                                   reason: "The given data was invalid.",
//                                   errors: {"username": ["The title must contain at least 6 characters"]})
//                let lingo = try req.application.lingoVapor.lingo()
//                return lingo.localize("custom_message", locale: "en")
            }
            return body.username
        }
    }
}
