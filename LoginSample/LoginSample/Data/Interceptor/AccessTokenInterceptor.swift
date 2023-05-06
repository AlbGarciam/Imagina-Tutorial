import Foundation

final class AccessTokenInterceptor: APIRequestInterceptor, APIResponseInterceptor {
    func intercept(_ request: inout URLRequest) {
        // Problem!! How to mock these values?
        if let token = SessionStorage.token {
            request.addValue(token, forHTTPHeaderField: "token")
        }
    }
    
    func intercept(_ data: Data, response: URLResponse) {
        let entity = try? JSONDecoder().decode(AccessTokenEntity.self, from: data)
        SessionStorage.token = entity?.token
    }
}

private extension AccessTokenInterceptor {
    struct AccessTokenEntity: Decodable {
        let token: String
        
        // As they are snake_case we have to convert the key to camelCase
        enum CodingKeys: String, CodingKey {
            case token = "token"
        }
    }
}
