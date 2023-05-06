import Combine
import Foundation

struct APISession {
    private static let session: URLSession = {
        let configuration = URLSessionConfiguration.default
        return URLSession(configuration: .default)
    }()
    
    private static var requestInterceptors: [APIRequestInterceptor] = []
    private static var responseInterceptors: [APIResponseInterceptor] = []
    
    static func request<Request: APIRequest>(_ apiRequest: Request) async throws  -> Data {
        var request = apiRequest.getRequest()
        do {
            requestInterceptors.forEach { $0.intercept(&request) }
            let (data, response) = try await session.data(for: request)
            guard let httpResponse = (response as? HTTPURLResponse), httpResponse.statusCode == 200 else {
                throw APIErrorResponse.network("") // Will be handled by the catch
            }
            responseInterceptors.forEach { $0.intercept(data, response: response) }
            return data
        } catch {
            throw APIErrorResponse.network(request.url?.relativePath ?? "")
        }
    }
    
    static func addRequestInterceptor(_ interceptor: APIRequestInterceptor) {
        requestInterceptors.append(interceptor)
    }
    
    static func addResponseInterceptor(_ interceptor: APIResponseInterceptor) {
        responseInterceptors.append(interceptor)
    }
}
