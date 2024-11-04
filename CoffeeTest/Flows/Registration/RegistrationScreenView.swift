//
//  RegistrationScreenView.swift
//  CoffeeTest
//
//  Created by Alexander Ognerubov on 30.10.2024.
//

import SwiftUI

struct RegistrationScreenView: View {

    @ObservedObject var viewModel: RegistrationViewModel

    var body: some View {
            VStack(spacing: 0) {
                VStack(spacing: DSConst.standartVPadding) {
                    CustomTextFieldView(textFieldName: "RegistrationScreen.email.textFieldName".localized, placeholder: "RegistrationScreen.email.placeholder".localized, isSecured: false, exampleString: $viewModel.emailString)
                    CustomTextFieldView(textFieldName: "RegistrationScreen.password.textFieldName".localized, placeholder: "RegistrationScreen.password.placeholder".localized, isSecured: true,  exampleString: $viewModel.passwordString)
                    CustomTextFieldView(textFieldName: "RegistrationScreen.repeatPassword.textFieldName".localized, placeholder: "RegistrationScreen.repeatPassword.placeholder".localized, isSecured: true,  exampleString: $viewModel.repeatPassString)
                }
                .padding(.bottom, DSConst.bigVPadding)
                CustomButton(action: {
                    viewModel.validateEmailAndPassword()
                }, buttonTitle: "RegistrationScreen.regButton.title".localized, isEnabled: true)
            }
            .padding(.horizontal, DSConst.standartPadding)
            .navigationTitle("RegistrationScreen.navBar.title".localized)
            .navigationBarTitleDisplayMode(.inline)
            .customizeNavigationBar()
            .alert("System message", isPresented: $viewModel.isAlertPresented) {
                Button("RegistrationScreen.alert.accept".localized, action: {
                    if viewModel.alertMessage == "RegistrationScreen.alert.registrationSuccess".localized {
                        viewModel.navPath.removeAll()
                    } else {
                        viewModel.isAlertPresented = false
                    }
                })
            } message: {
                Text(viewModel.alertMessage)
            }
        }
}

#Preview {
    struct PreviewStruct: View {
        @State var navPath = [String]()
        var body: some View {
            RegistrationScreenView(viewModel: RegistrationViewModel(navPath: $navPath, tokenManager: TokenManager()))
        }
    }
    return PreviewStruct()
}
