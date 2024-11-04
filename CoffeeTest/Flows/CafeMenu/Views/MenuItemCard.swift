//
//  MenuItemCard.swift
//  CoffeeTest
//
//  Created by Alexander Ognerubov on 02.11.2024.
//

import SwiftUI

struct MenuItemCard: View {
    @Binding var cart: [String: Int]
    let item: MenuItemsModel
    let geo: GeometryProxy

    var body: some View {
        VStack(alignment: .leading, spacing: DSConst.zero) {
            ItemImageView(item: item, geo: geo)
            VStack(alignment: .leading, spacing: DSConst.menuTextVPadding) {
                ItemNameView(item: item)
                ItemPriceAndCountView(cart: $cart, item: item)
            }
            .frame(minHeight: DSConst.menuItemHeight - DSConst.menuImageHeight, maxHeight: DSConst.menuItemHeight - DSConst.menuImageHeight, alignment: .leading)
        }
        .background(.customWhite)
        .cornerRadius(DSConst.smallCornerRadius)
        .shadow(radius: DSConst.shadowSize, y: DSConst.shadowSize)
    }
}


#Preview {
    struct PreviewStruct: View {
        @State var cart = [String: Int]()
        var body: some View {
            GeometryReader { geo in
                MenuItemCard(cart: $cart, item: Mocks.menuItems[0], geo: geo)
                    .frame(width: geo.size.width/2-22)
                    .padding()
            }
        }
    }
    return PreviewStruct()
}
