//
//  CustomTextFieldView.swift
//  CoffeeTest
//
//  Created by Alexander Ognerubov on 31.10.2024.
//

import SwiftUI

struct CustomTextFieldView: View {
    var textFieldName: String
    var placeholder: String
    @State var isSecured: Bool
    @Binding var exampleString: String

    var body: some View {
        VStack(spacing: DSConst.smallVPadding) {
            Text(textFieldName)
                .font(Font.system(size: DSConst.smallTextSize))
                .foregroundColor(.primaryText)
                .frame(maxWidth: .infinity, alignment: .leading)
            Group {
                ZStack {
                    if isSecured {
                        SecureField("", text: $exampleString).autocapitalization(.none)
                    } else {
                        TextField("", text: $exampleString).autocapitalization(.none)
                    }
                    if textFieldName != "e-mail" {
                        Button(action: {
                            isSecured.toggle()
                        }, label: {
                            Image(systemName: isSecured ? "eye" : "eye.slash")
                        })
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
            }
                .placeholder(when: exampleString.isEmpty) {
                    Text(placeholder)
                        .font(Font.system(size: DSConst.standartPadding))
                        .accentColor(.secondary)
                }
                .frame(height: DSConst.standartTextFieldHeight)
                .padding(.horizontal, DSConst.standartPadding)
                .overlay(
                    RoundedRectangle(cornerRadius: DSConst.standartCornerRadius)
                        .stroke(Color.primaryText, lineWidth: DSConst.standartStrokeSize)
                )
                .font(Font.system(size: DSConst.standartPadding))
                .foregroundColor(.secondaryText)
        }
    }
}

#Preview {
    struct PreviewStruct: View {
        @State var emailString = ""
        var body: some View {
            CustomTextFieldView(textFieldName: "e-mail", placeholder: "example@example.ru", isSecured: false, exampleString: $emailString)
        }
    }
    return PreviewStruct()
}
