struct LoginEntity: Decodable {
    let identifier: Int
    
    // As they are snake_case we have to convert the key to camelCase
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
    }
}
