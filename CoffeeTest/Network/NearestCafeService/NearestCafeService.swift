//
//  NearestCafeService.swift
//  CoffeeTest
//
//  Created by Alexander Ognerubov on 03.11.2024.
//

import Foundation
import Moya
import Combine
import CombineMoya

protocol NearestCafeServiceProtocol {
    func getNearestCafes(token: String) -> AnyPublisher<[NearestCafeModel], MoyaError>
}

final class NearestCafeService: NearestCafeServiceProtocol {

    private let provider = MoyaProvider<NearestCafeRequestCollection>()

    func getNearestCafes(token: String) -> AnyPublisher<[NearestCafeModel], Moya.MoyaError> {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let provider = provider.requestPublisher(.getNearestCafes(token: token))
        return provider
            .map([NearestCafeModel].self, using: decoder)
            .eraseToAnyPublisher()
    }
}

