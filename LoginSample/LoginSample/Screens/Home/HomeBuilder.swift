import SwiftUI

struct HomeBuilder {
    @ViewBuilder
    static func build(characterId: Int) -> HomeView {
        HomeView(viewModel: HomeViewModel(characterId: characterId))
    }
}
