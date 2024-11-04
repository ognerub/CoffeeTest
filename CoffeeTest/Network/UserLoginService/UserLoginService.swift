//
//  UserLoginService.swift
//  CoffeeTest
//
//  Created by Alexander Ognerubov on 03.11.2024.
//

import Foundation
import Moya
import Combine
import CombineMoya

protocol UserLoginServiceProtocol {
    func postUser(login: String, password: String) -> AnyPublisher<UserTokenModel, MoyaError>
}

final class UserLoginService: UserLoginServiceProtocol {

    private let provider = MoyaProvider<UserLoginRequestCollection>()

    func postUser(login: String, password: String) -> AnyPublisher<UserTokenModel, Moya.MoyaError> {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return provider.requestPublisher(.postUser(login: login, password: password))
            .map(UserTokenModel.self, using: decoder)
            .eraseToAnyPublisher()
    }
}
