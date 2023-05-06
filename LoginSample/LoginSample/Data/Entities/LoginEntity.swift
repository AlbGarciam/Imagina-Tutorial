struct LoginEntity: Decodable {
    let accessToken: String
    let refreshToken: String
    let tokenType: String
    
    // As they are snake_case we have to convert the key to camelCase
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case tokenType = "token_type"
    }
}
