//
//  CoffeeTestApp.swift
//  CoffeeTest
//
//  Created by Alexander Ognerubov on 30.10.2024.
//

import SwiftUI

@main
struct CoffeeTestApp: App {
    var body: some Scene {
        WindowGroup {
            AppRootView(tokenManager: TokenManager())
        }
    }
}
