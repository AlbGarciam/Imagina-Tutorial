import Combine
import Foundation

public enum Methods: String, Codable {
    case GET, POST, UPDATE, DELETE, PATCH
}

public protocol APIRequest {
    associatedtype Response: Decodable // The way to add a generic into a protocol
    
    typealias APIRequestResponse = Result<Response, APIErrorResponse>
    typealias APIRequestCompletion = (APIRequestResponse) -> ()
    
    var method: Methods { get }
    var body: Encodable? { get }
    var baseUrl: String { get }
    var path: String { get }
    var headers: [String:String] { get }
    var parameters: [String:String] { get }
}

public extension APIRequest {
    var baseUrl: String { "dummyjson.com" }
    var parameters: [String:String] { return [:] }
    var headers: [String:String] { return [ "Accept": "application/json", "Content-Type": "application/json" ] }
    var body: Encodable? { nil }
    
    func getRequest() -> URLRequest {
        // Compose the different parts of a URL
        var components = URLComponents()
        components.scheme = "https"
        components.host = baseUrl
        components.path = path

        if !parameters.isEmpty {
            components.queryItems = parameters.map { URLQueryItem(name: $0, value: $1) }
        }

        guard let finalURL = components.url else {
            fatalError("Impossible to retrieve final URL")
        }
        
        // Create the request
        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
        if let body = body, method != .GET {
            request.httpBody = try? JSONEncoder().encode(body)
        }
        request.allHTTPHeaderFields = headers
        request.timeoutInterval = 30
        
        return request
    }

    func makeRequest() async throws -> Response {
        do {
            let data = try await APISession.request(self)
            if Response.self == Data.self {
                return data as! Response
            }
            return try JSONDecoder().decode(Response.self, from: data)
        } catch {
            if let failure = error as? APIErrorResponse {
                throw failure
            }
            throw APIErrorResponse.parseData(path)
        }
    }
}
