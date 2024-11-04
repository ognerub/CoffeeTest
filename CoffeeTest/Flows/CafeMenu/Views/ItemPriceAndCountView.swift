//
//  ItemPriceAndCountView.swift
//  CoffeeTest
//
//  Created by Alexander Ognerubov on 02.11.2024.
//

import SwiftUI

struct ItemPriceAndCountView: View {
    @Binding var cart: [String: Int]
    let item: MenuItemsModel

    var body: some View {
        HStack(spacing: DSConst.zero) {
            itemPriceView
            Spacer()
            ItemCounterView(cart: $cart, item: item)
        }
        .padding(.bottom, DSConst.menuItemPadding)
    }

    var itemPriceView: some View {
        Text("\(item.price) \("CafeMenuScreenView.menuItem.currency".localized)")
            .font(Font.system(size: 14, weight: .bold))
            .foregroundColor(.primaryText)
            .lineLimit(1)
            .padding(.leading, DSConst.menuItemPadding)
    }
}

#Preview {
    struct PreviewStruct: View {
        @State var cart = [String: Int]()
        var body: some View {
            ItemPriceAndCountView(cart: $cart, item: Mocks.menuItems[0])
                .frame(maxWidth: 200)
        }
    }
    return PreviewStruct()
}
