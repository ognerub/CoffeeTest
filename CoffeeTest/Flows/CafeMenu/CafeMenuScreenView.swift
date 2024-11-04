//
//  CafeMenuScreenView.swift
//  CoffeeTest
//
//  Created by Alexander Ognerubov on 01.11.2024.
//

import SwiftUI

struct CafeMenuScreenView: View {

    @ObservedObject var viewModel: CafeMenuViewModel

    var body: some View {
        GeometryReader { geo in
            ZStack {
                ScrollView {
                    LazyVGrid(columns: [GridItem(spacing: DSConst.gridSpacing), GridItem()], spacing: DSConst.gridSpacing, content: {
                        ForEach(viewModel.menuItems) { item in
                            MenuItemCard(cart: $viewModel.cart, item: item, geo: geo)
                        }
                    })
                    .padding(DSConst.gridHspacing)
                }
                HStack {
                    NavigationLink(
                        destination: ClientCartScreenView(items: viewModel.menuItems, cart: $viewModel.cart).toolbarRole(.editor),
                        label: {
                            CustomButton(action: { print("pressed") }, buttonTitle: "CafeMenuScreenView.cartButton.title".localized, isEnabled: false)
                                .padding(.horizontal, DSConst.standartPadding)
                        }
                    )
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
            .navigationTitle("CafeMenuScreenView.navBar.title".localized)
            .navigationBarTitleDisplayMode(.inline)
            .customizeNavigationBar()
            .onAppear() {
                viewModel.getCafeMenu()
            }
        }
    }
}

#Preview {
    CafeMenuScreenView(viewModel: CafeMenuViewModel(id: 1, tokenManager: TokenManager()))
}
