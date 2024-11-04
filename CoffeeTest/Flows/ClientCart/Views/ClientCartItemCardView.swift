//
//  ClientCartItemCardView.swift
//  CoffeeTest
//
//  Created by Alexander Ognerubov on 02.11.2024.
//

import SwiftUI

struct ClientCartItemCardView: View {
    @Binding var cart: [String: Int]
    let item: MenuItemsModel?

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.buttonText)
                .cornerRadius(DSConst.smallCornerRadius)
                .shadow(radius: DSConst.shadowSize, y: DSConst.shadowSize)
            HStack(spacing: DSConst.zero) {
                VStack(spacing: DSConst.additionsVPadding) {
                    Text(item?.name ?? "Noname")
                        .font(Font.system(size: DSConst.standartTextSize, weight: .bold))
                        .foregroundColor(.primaryText)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("\(item?.price ?? 0) rub")
                        .font(Font.system(size: DSConst.smallestTextSize, weight: .regular))
                        .foregroundColor(.primaryText)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal, DSConst.smallHPadding)
                .padding(.vertical, DSConst.middleVPadding)
                if let item = item {
                    ItemCounterView(cart: $cart, item: item)
                }
            }
        }
        .padding(.horizontal, DSConst.standartPadding)
        .frame(height: DSConst.standartRowHeight)
    }
}

#Preview {
    struct PreviewStruct: View {
        @State var cart = ["Capuchino": 0]
        var body: some View {
            ClientCartItemCardView(cart: $cart, item: Mocks.menuItems[0])
        }
    }
    return PreviewStruct()
}
