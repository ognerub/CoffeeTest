//
//  NearestСafeScreenView.swift
//  CoffeeTest
//
//  Created by Alexander Ognerubov on 31.10.2024.
//

import SwiftUI
import CoreLocation

struct NearestСafeScreenView: View {

    @ObservedObject var viewModel: NearestCafeViewModel

    var body: some View {
        NavigationStack {
            ZStack {
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .ignoresSafeArea(.all)
                } else {
                    ScrollView {
                        VStack {
                            ForEach(viewModel.cafes) { cafe in
                                NavigationLink(
                                    destination: CafeMenuScreenView(viewModel: CafeMenuViewModel(id: cafe.id, tokenManager: viewModel.tokenManager)).toolbarRole(.editor),
                                    label: { NearestCafeCardView(cafe: cafe) }
                                )
                            }
                        }
                        .padding(.top, DSConst.standartPadding)
                        .padding(.bottom, DSConst.standartRowHeight)
                    }
                    CustomButton(action: { print("Show map") }, buttonTitle: "NearestСafeScreenView.mapButton.title".localized, isEnabled: true)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                        .padding(.horizontal, DSConst.standartPadding)
                }
            }
            .navigationTitle("NearestСafeScreenView.navBar.title".localized)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: NavigationBarBackButtonView(action: {
                viewModel.isAlertVisible = true
            }, isVisible: true))
            .customizeNavigationBar()
            .onAppear() {
                viewModel.getNearestCafes()
            }
            .alert("NearestСafeScreenView.alert.title".localized, isPresented: $viewModel.isAlertVisible) {
                Button(role: .cancel) {
                    viewModel.isAlertVisible = false
                } label: { Text("NearestСafeScreenView.alert.cancel".localized) }
                Button() {
                    viewModel.isAlertVisible = false
                    viewModel.tokenManager.clearToken()
                } label: { Text("NearestСafeScreenView.alert.accept".localized) }
            } message: { Text("NearestСafeScreenView.alert.message".localized) }
        }
    }
}

#Preview {
    NearestСafeScreenView(viewModel: NearestCafeViewModel(locationManager: CLLocationManager()))
}
