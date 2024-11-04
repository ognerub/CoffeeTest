//
//  RegistrationRequestCollection.swift
//  CoffeeTest
//
//  Created by Alexander Ognerubov on 04.11.2024.
//

import Foundation
import Moya

enum RegistrationRequestCollection {
    case registerUser(login: String, password: String)
}

extension RegistrationRequestCollection: TargetType {

    var baseURL: URL { URL(string: NetworkConstants.baseUrl) ?? URL(filePath: "") }

    var path: String {
        switch self {
        case .registerUser(_,_):
            return NetworkConstants.authRegister
        }
    }

    var method: Moya.Method {
        switch self {
        case .registerUser:
            return .post
        }
    }

    var task: Moya.Task {
        switch self {
        case .registerUser(let login, let password):
            let params = ["login" : login, "password" : password]
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        }
    }

    var headers: [String : String]? {
        return [
            NetworkConstants.accept: NetworkConstants.applicationJson,
            NetworkConstants.contentType: NetworkConstants.applicationJson
        ]
    }
}

