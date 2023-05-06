import Foundation

struct ProfileEntity: Decodable {
    let identifier: String
    let username: String
    let avatar: URL
    let posts: [PostEntity]
    
    enum CodingKeys: String, CodingKey {
        case identifier
        case username
        case avatar
        case posts
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Self.CodingKeys.self)
        identifier = try container.decode(String.self, forKey: .identifier)
        username = try container.decode(String.self, forKey: .username)
        posts = try container.decode([PostEntity].self, forKey: .posts)
        
        let avatarAsString = try container.decode(String.self, forKey: .avatar)
        guard let avatarAsURL = URL(string: avatarAsString) else {
            throw APIErrorResponse.parseData("")
        }
        avatar = avatarAsURL
    }
}
