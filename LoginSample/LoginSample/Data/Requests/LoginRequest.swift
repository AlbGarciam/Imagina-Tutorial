import Foundation

struct LoginRequest: APIRequest {
    typealias Response = LoginEntity
    
    let method: Methods = .POST
    let path: String = "albgarciam/Imagina-DummyServer/login"
    let body: Any
    
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
