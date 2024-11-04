//
//  ItemCounterView.swift
//  CoffeeTest
//
//  Created by Alexander Ognerubov on 02.11.2024.
//

import SwiftUI

struct ItemCounterView: View {
    @Binding var cart: [String: Int]
    let item: MenuItemsModel

    var body: some View {
        ItemCounterButton(cart: $cart, item: item, type: .minus)
        itemAmountTextView
        ItemCounterButton(cart: $cart, item: item, type: .plus)
    }

    var itemAmountTextView: some View {
        Text("\(cart.first(where: { $0.key == item.name })?.value ?? 0)")
            .font(Font.system(size: 14))
            .minimumScaleFactor(0.2)
            .frame(minWidth: 28)
            .lineLimit(1)
            .foregroundColor(.primaryText)
    }
}

#Preview {
    struct PreviewStruct: View {
        @State var cart = [String: Int]()
        var body: some View {
            ItemCounterView(cart: $cart, item: Mocks.menuItems[0])
                .frame(maxWidth: 200)
        }
    }
    return PreviewStruct()
}
