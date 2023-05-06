import Foundation

struct LoginRequest: APIRequest {
    typealias Response = LoginEntity
    
    let method: Methods = .POST
    let path: String = "/auth/login"
    let body: Encodable?
    
    init(username: String, password: String) {
        body = Entity(username: username, password: password)
    }
}

private extension LoginRequest {
    struct Entity: Encodable {
        let username: String
        let password: String
    }
}
