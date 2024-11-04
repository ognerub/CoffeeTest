//
//  View+Extension.swift
//  CoffeeTest
//
//  Created by Alexander Ognerubov on 31.10.2024.
//

import SwiftUI

extension View {
    func customizeNavigationBar() -> some View {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(Color.navigationBar)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.primaryText]
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        return self
    }

    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }

    func onBecomingVisible(perform action: @escaping () -> Void) -> some View {
        modifier(BecomingVisible(action: action))
    }
}

private struct BecomingVisible: ViewModifier {

    @State var action: (() -> Void)?

    func body(content: Content) -> some View {
        content.overlay {
            GeometryReader { proxy in
                Color.clear
                    .preference(
                        key: VisibleKey.self,
                        value: UIScreen.main.bounds.intersects(proxy.frame(in: .global))
                    )
                    .onPreferenceChange(VisibleKey.self) { isVisible in
                        guard isVisible, let action else { return }
                        action()
                    }
            }
        }
    }

    struct VisibleKey: PreferenceKey {
        static var defaultValue: Bool = false
        static func reduce(value: inout Bool, nextValue: () -> Bool) { }
    }
}

