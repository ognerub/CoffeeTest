//
//  LoginScreenView.swift
//  CoffeeTest
//
//  Created by Alexander Ognerubov on 31.10.2024.
//

import SwiftUI
import CoreLocation

struct LoginScreenView: View {
    
    @ObservedObject var viewModel: LoginViewModel

    var body: some View {
        NavigationStack(path: $viewModel.navPath) {
            VStack(spacing: 0) {
                VStack(spacing: DSConst.standartVPadding) {
                    CustomTextFieldView(textFieldName: "LoginScreenView.email.textFieldName".localized, placeholder: "LoginScreenView.email.placeholder".localized, isSecured: false, exampleString: $viewModel.emailString)
                    CustomTextFieldView(textFieldName: "LoginScreenView.password.textFieldName".localized, placeholder: "LoginScreenView.password.placeholder".localized, isSecured: true,  exampleString: $viewModel.passwordString)
                }
                .padding(.bottom, DSConst.bigVPadding)
                CustomButton(action: {
                    viewModel.postUser(login: viewModel.emailString, password: viewModel.passwordString)
                }, buttonTitle: "LoginScreenView.enterButton.title".localized, isEnabled: true)
                Button(action: {
                    viewModel.navPath.append(NavigationIdentifiers.registration.rawValue)
                }, label: {
                    Text("LoginScreenView.regButton.title".localized)
                })
                .padding()
            }
            .padding(.horizontal, DSConst.standartPadding)
            .navigationTitle("LoginScreenView.navBar.title".localized)
            .navigationBarTitleDisplayMode(.inline)
            .customizeNavigationBar()
            .navigationDestination(for: String.self) { textValue in
                switch textValue {
                case NavigationIdentifiers.nearestСafe.rawValue:
                    NearestСafeScreenView(viewModel: NearestCafeViewModel(locationManager: CLLocationManager())).toolbarRole(.editor)
                case NavigationIdentifiers.registration.rawValue:
                    RegistrationScreenView(viewModel: RegistrationViewModel(navPath: $viewModel.navPath, tokenManager: viewModel.tokenManager)).toolbarRole(.editor)
                default:
                    Text("Error to navigate")
                }
            }
            .alert("LoginScreenView.alert.title".localized, isPresented: $viewModel.isAlertPresented) {
                Button(role: .cancel) {
                    viewModel.isAlertPresented = false
                } label: {
                    Text("LoginScreenView.alert.repeat".localized)
                }
            } message: {
                Text(viewModel.errorMessage)
                    .lineLimit(5)
            }
        }
    }
}

#Preview {
    LoginScreenView(viewModel: LoginViewModel(tokenManager: TokenManager()))
}

