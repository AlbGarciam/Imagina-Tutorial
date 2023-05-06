struct GetProfileRequest: APIRequest {
    typealias Response = ProfileEntity
    
    let method: Methods = .GET
    let path: String = "albgarciam/Imagina-DummyServer/profile"
}
