import Foundation

struct ProfileEntity: Decodable {
    let identifier: Int
    let firstName: String
    let avatar: URL
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case firstName
        case image
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Self.CodingKeys.self)
        identifier = try container.decode(Int.self, forKey: .identifier)
        firstName = try container.decode(String.self, forKey: .firstName)
        
        let avatarAsString = try container.decode(String.self, forKey: .image)
        guard let avatarAsURL = URL(string: avatarAsString) else {
            throw APIErrorResponse.parseData("")
        }
        avatar = avatarAsURL
    }
}
