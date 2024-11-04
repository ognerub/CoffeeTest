//
//  RegistrationService.swift
//  CoffeeTest
//
//  Created by Alexander Ognerubov on 04.11.2024.
//

import Foundation
import Moya
import Combine
import CombineMoya

protocol RegistrationServiceProtocol {
    func registerUser(login: String, password: String) -> AnyPublisher<UserTokenModel, MoyaError>
}

final class RegistrationService: RegistrationServiceProtocol {

    private let provider = MoyaProvider<RegistrationRequestCollection>()

    func registerUser(login: String, password: String) -> AnyPublisher<UserTokenModel, Moya.MoyaError> {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return provider.requestPublisher(.registerUser(login: login, password: password))
            .map(UserTokenModel.self, using: decoder)
            .eraseToAnyPublisher()
    }
}


