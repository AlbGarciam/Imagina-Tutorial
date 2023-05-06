struct GetProfileRequest: APIRequest {
    typealias Response = ProfileEntity
    
    let method: Methods = .GET
    let path: String
    
    init(characterId: Int) {
        path = "/users/\(characterId)"
    }
}
