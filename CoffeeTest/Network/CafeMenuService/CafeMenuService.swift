//
//  CafeMenuService.swift
//  CoffeeTest
//
//  Created by Alexander Ognerubov on 04.11.2024.
//

import Foundation
import Moya
import Combine
import CombineMoya

protocol CafeMenuServiceProtocol {
    func getCafeMenu(token: String, id: Int) -> AnyPublisher<[MenuItemsModel], MoyaError>
}

final class CafeMenuService: CafeMenuServiceProtocol {

    private let provider = MoyaProvider<CafeMenuRequestCollection>()

    func getCafeMenu(token: String, id: Int) -> AnyPublisher<[MenuItemsModel], Moya.MoyaError> {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let provider = provider.requestPublisher(.getCafeMenu(token: token, id: id))
        return provider
            .map([MenuItemsModel].self, using: decoder)
            .eraseToAnyPublisher()
    }
}


