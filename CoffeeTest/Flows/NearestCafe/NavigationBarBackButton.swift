//
//  NavigationBarBackButton.swift
//  CoffeeTest
//
//  Created by Alexander Ognerubov on 04.11.2024.
//

import SwiftUI

struct NavigationBarBackButtonView: View {

    var action: () -> Void = { }
    var isVisible: Bool

    var body: some View {
        Button(action: {
            action()
        }, label: {
            Spacer()
            Image(.arrowBack)
//                    .accentColor(Color(asset: Asset.Colors.textPrimary))
//                    .tint(Color(asset: Asset.Colors.textPrimary))
                    .opacity(isVisible ? 1 : 0)
        })
        .frame(width: 24, height: 24, alignment: .center)
    }

}

#Preview {
    NavigationBarBackButtonView(isVisible: true)
}
