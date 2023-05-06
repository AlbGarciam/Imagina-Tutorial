import SwiftUI

struct LoginBuilder {
    @ViewBuilder
    static func build() -> LoginView {
        LoginView(viewModel: LoginViewModel())
    }
}
