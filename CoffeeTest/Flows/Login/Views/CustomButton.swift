//
//  CustomButton.swift
//  CoffeeTest
//
//  Created by Alexander Ognerubov on 31.10.2024.
//

import SwiftUI

struct CustomButton: View {
    let action: () -> ()
    let buttonTitle: String
    let isEnabled: Bool
    var body: some View {
        if isEnabled {
            Button(action: {
                action()
            }, label: {
                CustomButtonView(buttonTitle: buttonTitle)
            })
        } else {
            CustomButtonView(buttonTitle: buttonTitle)
        }
    }
}

#Preview {
    CustomButton(action: { print("pressed") }, buttonTitle: "Registration", isEnabled: false)
}

struct CustomButtonView: View {

    let buttonTitle: String

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: DSConst.standartCornerRadius)
                .foregroundColor(.button)
                .frame(height: DSConst.standartTextFieldHeight)
            Text(buttonTitle)
                .foregroundColor(.buttonText)
                .font(Font.system(size: DSConst.standartTextSize, weight: .bold))
        }
    }
}
