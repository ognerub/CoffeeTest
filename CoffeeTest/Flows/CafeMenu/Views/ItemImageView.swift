//
//  ItemImageView.swift
//  CoffeeTest
//
//  Created by Alexander Ognerubov on 02.11.2024.
//

import SwiftUI

struct ItemImageView: View {
    let item: MenuItemsModel
    let geo: GeometryProxy

    var body: some View {
        if geo.size.width > 0 {
            AsyncImage(url: item.imageURL) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: geo.size.width/2 - DSConst.gridSpacing - DSConst.gridHspacing/2, minHeight: DSConst.menuImageHeight, idealHeight: DSConst.menuImageHeight, maxHeight: DSConst.menuImageHeight)
                        .clipShape(.rect)
                        .contentShape(Rectangle())
                } else if phase.error != nil {
                    Image(systemName: "photo")
                        .frame(maxWidth: geo.size.width/2 - DSConst.gridSpacing - DSConst.gridHspacing/2, minHeight: DSConst.menuImageHeight, idealHeight: DSConst.menuImageHeight, maxHeight: DSConst.menuImageHeight)
                        .clipShape(.rect)
                        .contentShape(Rectangle())
                } else {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(maxWidth: geo.size.width/2 - DSConst.gridSpacing - DSConst.gridHspacing/2, minHeight: DSConst.menuImageHeight, idealHeight: DSConst.menuImageHeight, maxHeight: DSConst.menuImageHeight)
                        ProgressView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .ignoresSafeArea(.all)
                    }
                }
            }
        }
    }
}

#Preview {
    struct PreviewStruct: View {
        @State var cart = [String: Int]()
        var body: some View {
            GeometryReader { geo in
                ItemImageView(item: Mocks.menuItems[0], geo: geo)
            }
        }
    }
    return PreviewStruct()
}
