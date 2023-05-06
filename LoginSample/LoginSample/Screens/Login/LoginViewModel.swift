import Combine
import Foundation

final class LoginViewModel: ObservableObject {
    @Published var username: String = "kminchelle"
    @Published var password: String = "0lelplR"
    @Published var presentingHome: Bool = false
    @Published var readyToSend: Bool = false
    @Published var isLoading: Bool = false
    @Published var characterId: Int?
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        Publishers.Zip($username, $password)
            .sink { [weak self] username, password in
                self?.readyToSend = !username.isEmpty && !password.isEmpty
            }
            .store(in: &cancellables)
        $presentingHome
            .filter { !$0 }
            .sink {[weak self] _ in self?.characterId = nil }
            .store(in: &cancellables)
        $characterId
            .filter { $0 != nil }
            .sink {[weak self] _ in self?.presentingHome = true }
            .store(in: &cancellables)
    }
    
    @MainActor
    func onButtonTapped() async {
        isLoading = true
        do {
            let data = try await LoginRequest(username: username, password: password).makeRequest()
            characterId = data.identifier
        } catch {
            print("There was an error \(error.localizedDescription)")
        }
        isLoading = false
    }
}
