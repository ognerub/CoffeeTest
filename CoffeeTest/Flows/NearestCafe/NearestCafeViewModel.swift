//
//  NearestCafeViewModel.swift
//  CoffeeTest
//
//  Created by Alexander Ognerubov on 03.11.2024.
//

import Foundation
import CoreLocation
import Combine

final class NearestCafeViewModel: ObservableObject {
    let tokenManager: TokenManager
    @Published var cafes: [NearestCafeModel] = Mocks.cafes
    @Published var isLoading = false
    @Published var isAlertVisible = false

    private let locationManager: CLLocationManager
    private let service: NearestCafeServiceProtocol
    private var cancellable: AnyCancellable?

    init(
        locationManager: CLLocationManager,
        service: NearestCafeServiceProtocol = NearestCafeService(),
        tokenManager: TokenManager = TokenManager()
    ) {
        self.locationManager = locationManager
        self.service = service
        self.tokenManager = tokenManager
    }

    func getNearestCafes() {
        isLoading = true
        cancellable = service.getNearestCafes(token: tokenManager.token ?? "")
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] data in
                guard let self else { return }
                self.cafes = data.map( { self.createNearestCafeModelWithCoordsFrom($0) })
                self.isLoading = false
            }
    }

    private func createNearestCafeModelWithCoordsFrom(_ model: NearestCafeModel) -> NearestCafeModel {
        if let currentLoc = self.locationManager(self.locationManager, didUpdateLocations: []) {
            let currentCoords = CLLocation(latitude: currentLoc.latitude, longitude: currentLoc.longitude)
            let cafeCoords = CLLocation(latitude: Double(model.point.latitude) ?? 0, longitude: Double(model.point.longitude) ?? 0)
            let distance = currentCoords.distance(from: cafeCoords) / 1000
            return NearestCafeModel(id: model.id, name: model.name, point: model.point, distance: String(distance.rounded(.up)))
        } else {
            return model
        }
    }
}

extension NearestCafeViewModel {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) -> CLLocationCoordinate2D? {
        guard let currentLoc: CLLocationCoordinate2D = manager.location?.coordinate else { return nil }
        return currentLoc
    }
}
