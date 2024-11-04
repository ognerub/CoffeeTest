//
//  CafeMenuViewModel.swift
//  CoffeeTest
//
//  Created by Alexander Ognerubov on 04.11.2024.
//

import Foundation
import Combine

final class CafeMenuViewModel: ObservableObject {

    let id: Int
    @Published var menuItems = [MenuItemsModel]()
    @Published var cart = [String: Int]()
    @Published var isLoading = false

    private let tokenManager: TokenManager
    private let service: CafeMenuServiceProtocol
    private var cancellable: AnyCancellable?

    init(id: Int, tokenManager: TokenManager, service: CafeMenuServiceProtocol = CafeMenuService()) {
        self.id = id
        self.tokenManager = tokenManager
        self.service = service
    }

    func getCafeMenu() {
        isLoading = true
        cancellable = service.getCafeMenu(token: tokenManager.token ?? "", id: id)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] data in
                guard let self else { return }
                self.menuItems = data
                for item in menuItems {
                    cart.updateValue(0, forKey: item.name)
                }
                self.isLoading = false
            }
    }
}
