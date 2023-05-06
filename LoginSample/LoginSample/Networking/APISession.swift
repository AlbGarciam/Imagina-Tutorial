import Combine
import Foundation

struct APISession {
    private static let session: URLSession = {
        let configuration = URLSessionConfiguration.default
        return URLSession(configuration: .default)
    }()
    
    static func request<Request: APIRequest>(_ apiRequest: Request) async throws  -> Data {
        let request = apiRequest.getRequest()
        do {
            let (data, response) = try await session.data(for: request)
            guard let httpResponse = (response as? HTTPURLResponse), httpResponse.statusCode == 200 else {
                throw APIErrorResponse.network("") // Will be handled by the catch
            }
            return data
        } catch {
            throw APIErrorResponse.network(request.url?.relativePath ?? "")
        }
        
    }
}
