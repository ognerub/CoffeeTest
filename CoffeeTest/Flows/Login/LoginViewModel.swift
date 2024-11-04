//
//  LoginViewModel.swift
//  CoffeeTest
//
//  Created by Alexander Ognerubov on 03.11.2024.
//

import Foundation
import Combine

enum NavigationIdentifiers: String {
    case registration = "RegistrationScreenView"
    case nearestСafe = "NearestСafeScreenView"
    case cafeMenu = "CafeMenuScreenView"
}

final class LoginViewModel: ObservableObject {
    @Published var emailString = ""
    @Published var passwordString = ""
    @Published var navPath = [String]()
    @Published var isLoading = false
    @Published var isAlertPresented = false
    @Published var errorMessage = ""

    let tokenManager: TokenManager
    private let service: UserLoginServiceProtocol
    private var cancellable: AnyCancellable?

    init(
        service: UserLoginServiceProtocol = UserLoginService(),
        tokenManager: TokenManager
    ) {
        self.service = service
        self.tokenManager = tokenManager
    }

    func postUser(login: String, password: String) {
        isLoading = true
        cancellable = service.postUser(login: login, password: password)
            .sink { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.isAlertPresented = true
                }
            } receiveValue: { [weak self] data in
                guard let self else { return }
                self.isLoading = false
                tokenManager.store(token: "Bearer \(data.token)", interval: data.tokenLifetime/60/60)
            }
    }
}
