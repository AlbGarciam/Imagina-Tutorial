import Foundation

protocol APIInterceptor { }

protocol APIResponseInterceptor: APIInterceptor {
    func intercept(_ data: Data, response: URLResponse)
}

protocol APIRequestInterceptor: APIInterceptor {
    func intercept(_ request: inout URLRequest)
}
