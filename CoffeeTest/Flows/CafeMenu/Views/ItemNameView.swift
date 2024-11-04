//
//  ItemNameView.swift
//  CoffeeTest
//
//  Created by Alexander Ognerubov on 02.11.2024.
//

import SwiftUI

struct ItemNameView: View {
    let item: MenuItemsModel

    var body: some View {
        Text(item.name)
            .font(Font.system(size: 15, weight: .medium))
            .lineLimit(1)
            .foregroundColor(.secondaryText)
            .padding(.top, DSConst.menuItemPadding)
            .padding(.leading, DSConst.menuItemPadding)
    }
}

#Preview {
    ItemNameView(item: Mocks.menuItems[0])
}
