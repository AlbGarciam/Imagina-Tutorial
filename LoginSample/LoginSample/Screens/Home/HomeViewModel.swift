import Foundation

final class HomeViewModel: ObservableObject {
    @Published var error: String?
    @Published var isLoading: Bool = false
    @Published var profile: ProfileEntity?
    
    private let characterId: Int
    
    init(characterId: Int) {
        self.characterId = characterId
    }
    
    @MainActor
    func onViewAppeared() async {
        isLoading = true
        do {
            profile = try await GetProfileRequest(characterId: characterId).makeRequest()
            isLoading = false
        } catch {
            self.error = "Something went wrong 🥲"
            isLoading = false
        }
    }
}
