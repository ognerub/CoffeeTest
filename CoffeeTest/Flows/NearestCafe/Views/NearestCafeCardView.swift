//
//  NearestCafeCardView.swift
//  CoffeeTest
//
//  Created by Alexander Ognerubov on 01.11.2024.
//

import SwiftUI

struct NearestCafeCardView: View {
    let cafe: NearestCafeModel

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.buttonText)
                .cornerRadius(DSConst.smallCornerRadius)
                .shadow(radius: DSConst.shadowSize, y: DSConst.shadowSize)
            VStack(spacing: DSConst.additionsVPadding) {
                Text(cafe.name)
                    .font(Font.system(size: DSConst.standartTextSize, weight: .bold))
                    .foregroundColor(.primaryText)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("\(cafe.distance ?? "0") \("NearestСafeScreenView.cafe.distance".localized)")
                    .font(Font.system(size: DSConst.smallestTextSize, weight: .regular))
                    .foregroundColor(.primaryText)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, DSConst.smallHPadding)
            .padding(.vertical, DSConst.middleVPadding)
        }
        .padding(.horizontal, DSConst.standartPadding)
        .frame(height: DSConst.standartRowHeight)
    }
}

#Preview {
    NearestCafeCardView(cafe: NearestCafeModel(id: 1, name: "Coffe like", point: NearestCafePoint(latitude: "", longitude: ""), distance: "1 km from you"))
}
