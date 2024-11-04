//
//  ClientCartScreenView.swift
//  CoffeeTest
//
//  Created by Alexander Ognerubov on 02.11.2024.
//

import SwiftUI

struct ClientCartScreenView: View {

    let items: [MenuItemsModel]
    @Binding var cart: [String: Int]

    var body: some View {
        ZStack {
            if cart.compactMap( { $0.value } ).reduce(0, +) > 0 {
                ScrollView {
                    VStack {
                        ForEach(cart.sorted(by: >), id: \.key) { key, value in
                            if value > 0 {
                                ClientCartItemCardView(
                                    cart: $cart,
                                    item: items.first(where: { $0.name == key })
                                )
                            }
                        }
                    }
                    .padding(.top, DSConst.standartPadding)
                    .padding(.bottom, DSConst.standartRowHeight)
                }
                HStack {
                    NavigationLink(destination: {
                        InfoTextView(text: "ClientCartScreenView.successPay.infoText".localized)
                    }, label: {

                        CustomButton(action: { }, buttonTitle: "ClientCartScreenView.payButton.title".localized, isEnabled: false)
                            .padding(.horizontal, DSConst.standartPadding)
                    })
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
            } else {
                InfoTextView(text: "ClientCartScreenView.cart.empty".localized)
            }
        }
        .navigationTitle("ClientCartScreenView.navBar.title".localized)
        .navigationBarTitleDisplayMode(.inline)
        .customizeNavigationBar()
    }
}

#Preview {
    struct PreviewStruct: View {
        @State var cart = ["Capuchino": 1]
        var body: some View {
            ClientCartScreenView(items: Mocks.menuItems, cart: $cart)
        }
    }
    return PreviewStruct()
}
