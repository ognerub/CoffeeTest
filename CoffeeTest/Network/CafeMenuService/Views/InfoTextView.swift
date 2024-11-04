//
//  InfoTextView.swift
//  CoffeeTest
//
//  Created by Alexander Ognerubov on 04.11.2024.
//

import SwiftUI

struct InfoTextView: View {
    let text: String

    var body: some View {
        Text(text)
            .frame(maxWidth: .infinity, alignment: .center)
            .multilineTextAlignment(.center)
            .font(Font.system(size: 24, weight: .medium))
            .foregroundColor(.primaryText)
            .padding(.horizontal, DSConst.gridSpacing)
    }
}

#Preview {
    InfoTextView(text: "Info text")
}
