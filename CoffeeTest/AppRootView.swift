//
//  AppRootView.swift
//  CoffeeTest
//
//  Created by Alexander Ognerubov on 04.11.2024.
//

import SwiftUI
import CoreLocation

struct AppRootView: View {

    @ObservedObject var tokenManager: TokenManager
    private let locationManager: CLLocationManager

    init(tokenManager: TokenManager,
         locationManager: CLLocationManager = CLLocationManager()) {
        self.tokenManager = tokenManager
        self.locationManager = locationManager
        activateLocation()
    }

    var body: some View {
        Group {
            if tokenManager.token != nil && tokenManager.checkToken() {
                NearestСafeScreenView(viewModel: NearestCafeViewModel(locationManager: locationManager, tokenManager: tokenManager))
            } else {
                LoginScreenView(viewModel: LoginViewModel(tokenManager: tokenManager))
            }
        }
    }

    private func activateLocation() {
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
    }
}

#Preview {
    AppRootView(tokenManager: TokenManager())
}
