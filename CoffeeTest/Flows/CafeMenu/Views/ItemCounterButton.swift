//
//  ItemCounterButton.swift
//  CoffeeTest
//
//  Created by Alexander Ognerubov on 02.11.2024.
//

import SwiftUI

enum ItemCounterButtonType {
    case plus
    case minus
}

struct ItemCounterButton: View {
    @Binding var cart: [String: Int]
    let item: MenuItemsModel
    let type: ItemCounterButtonType

    var body: some View {
        Button(action: {
            if type == .plus {
                cart[item.name]? += 1
            } else {
                if let cart = cart[item.name] {
                    if cart > 0 {
                        self.cart[item.name]? -= 1
                    }
                }
            }
        }, label: {
            Image(systemName: type == .plus ? "plus" : "minus")
                .frame(width: 24, height: 24)
                .foregroundColor(.secondaryText)
                .padding(.trailing, type == .plus ? DSConst.menuItemPadding : 0)
        })
    }
}

#Preview {
    struct PreviewStruct: View {
        @State var cart = [String: Int]()
        var body: some View {
            ItemCounterButton(cart: $cart, item: Mocks.menuItems[0], type: .plus)
        }
    }
    return PreviewStruct()
}
