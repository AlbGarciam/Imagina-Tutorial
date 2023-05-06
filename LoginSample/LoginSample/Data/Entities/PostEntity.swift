import Foundation

struct PostEntity: Decodable {
    let identifier: String
    let creationDate: Date
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case identifier
        case createdOn = "created_on"
        case format
        case title
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        identifier = try container.decode(String.self, forKey: .identifier)
        title = try container.decode(String.self, forKey: .title)
        
        let dateFormat = try container.decode(String.self, forKey: .format)
        let created = try container.decode(String.self, forKey: .createdOn)
        
        // Cast date from string to Date
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = dateFormat
        
        guard let creationDate = dateFormatter.date(from:created) else {
            throw APIErrorResponse.parseData("")
        }
        
        self.creationDate = creationDate
    }
}
