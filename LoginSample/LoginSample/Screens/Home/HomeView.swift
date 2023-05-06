//
//  HomeView.swift
//  LoginSample
//
//  Created by Alberto García-Muñoz on 6/5/23.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView()
            }
            viewModel.error.map { Text($0) }
                .foregroundColor(.primary)
                .font(.headline)
            viewModel.profile.map { generateProfile($0) }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .task { await viewModel.onViewAppeared() }
    }
    
    @ViewBuilder
    private func generateProfile(_ profile: ProfileEntity) -> some View {
        VStack(spacing: 20) {
            AsyncImage(url: profile.avatar) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 120, height: 120)
            .background(Color.gray)
            .clipShape(Circle())
            (Text("Hello ") + Text(profile.firstName))
                .font(.largeTitle)
                .fontWeight(.bold)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeBuilder.build(characterId: 1)
    }
}
