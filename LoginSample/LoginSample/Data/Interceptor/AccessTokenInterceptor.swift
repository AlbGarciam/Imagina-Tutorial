import Foundation

final class AccessTokenInterceptor: APIRequestInterceptor, APIResponseInterceptor {
    func intercept(_ request: inout URLRequest) {
        // Problem!! How to mock these values?
        if let accessToken = SessionStorage.accessToken {
            request.addValue(accessToken, forHTTPHeaderField: "access_token")
        }
    }
    
    func intercept(_ data: Data, response: URLResponse) {
        let entity = try? JSONDecoder().decode(AccessTokenEntity.self, from: data)
        SessionStorage.accessToken = entity?.accessToken
    }
}

private extension AccessTokenInterceptor {
    struct AccessTokenEntity: Decodable {
        let accessToken: String
        
        // As they are snake_case we have to convert the key to camelCase
        enum CodingKeys: String, CodingKey {
            case accessToken = "access_token"
        }
    }
}
