//
//  LoginSampleApp.swift
//  LoginSample
//
//  Created by Alberto García-Muñoz on 6/5/23.
//

import SwiftUI

@main
struct LoginSampleApp: App {
    init() {
        let interceptor = AccessTokenInterceptor()
        APISession.addRequestInterceptor(interceptor)
        APISession.addResponseInterceptor(interceptor)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
