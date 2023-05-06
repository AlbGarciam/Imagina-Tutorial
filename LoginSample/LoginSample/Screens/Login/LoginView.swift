//
//  LoginView.swift
//  LoginSample
//
//  Created by Alberto García-Muñoz on 6/5/23.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel: LoginViewModel
    
    var body: some View {
        VStack(spacing: 24) {
            TextField("Username", text: $viewModel.username)
                .padding(12)
                .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(.secondary, lineWidth: 2)
                )
            SecureField("Password", text: $viewModel.password)
                .padding(12)
                .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(.secondary, lineWidth: 2)
                )
            HStack {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    Button("Sign in") { Task { await viewModel.onButtonTapped() } }
                        .disabled(!viewModel.readyToSend)
                        .padding(12)
                }
            }
            .frame(height: 50)
        }
        .frame(maxWidth: 350)
        .navigationDestination(isPresented: $viewModel.presentingHome) {
            viewModel.characterId.map { HomeBuilder.build(characterId: $0) }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginBuilder.build()
    }
}
