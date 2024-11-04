//
//  RegistrationViewModel.swift
//  CoffeeTest
//
//  Created by Alexander Ognerubov on 04.11.2024.
//

import SwiftUI
import Combine

final class RegistrationViewModel: ObservableObject {
    @Published var emailString = ""
    @Published var passwordString = ""
    @Published var repeatPassString = ""
    @Published var isLoading = false
    @Published var isAlertPresented = false
    @Published var alertMessage = ""
    @Binding var navPath: [String]

    private let service: RegistrationServiceProtocol
    private let tokenManager: TokenManager
    private var cancellable: AnyCancellable?

    init(
        navPath: Binding<[String]>,
        service: RegistrationServiceProtocol = RegistrationService(),
        tokenManager: TokenManager
    ) {
        self._navPath = navPath
        self.service = service
        self.tokenManager = tokenManager
    }

    func validateEmailAndPassword() {
        if !isValidEmail() {
            alertMessage = "RegistrationScreen.alert.validateEmail".localized
            isAlertPresented = true
        } else if !isValidPassword() {
            alertMessage = "RegistrationScreen.alert.validatePassword".localized
            isAlertPresented = true
        } else if passwordString != repeatPassString {
            alertMessage = "RegistrationScreen.alert.validatePasswords".localized
            isAlertPresented = true
        } else {
            registerUser()
        }
    }

    private func isValidEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format:"SELF MATCHES %@", emailRegex).evaluate(with: emailString)
    }

    private func isValidPassword() -> Bool {
        let passwordRegex = "^(?=.*[A-Z])(?=.*[0-9])(?=.[a-z]).{6,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: passwordString)
    }

    private func registerUser() {
        isLoading = true
        cancellable = service.registerUser(login: emailString, password: passwordString)
            .sink { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.alertMessage = error.localizedDescription
                    self.isAlertPresented = true
                }
            } receiveValue: { [weak self] data in
                guard let self else { return }
                self.isLoading = false
                tokenManager.store(token: "Bearer \(data.token)", interval: data.tokenLifetime/60/60)
                alertMessage = "RegistrationScreen.alert.registrationSuccess".localized
                isAlertPresented = true
            }
    }
}
