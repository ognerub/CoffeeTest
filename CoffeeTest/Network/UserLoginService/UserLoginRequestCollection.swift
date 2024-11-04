//
//  UserLoginRequestCollection.swift
//  CoffeeTest
//
//  Created by Alexander Ognerubov on 03.11.2024.
//

import Foundation
import Moya

enum UserLoginRequestCollection {
    case postUser(login: String, password: String)
}

extension UserLoginRequestCollection: TargetType {

    var baseURL: URL { URL(string: NetworkConstants.baseUrl) ?? URL(filePath: "") }

    var path: String {
        switch self {
        case .postUser(_,_):
            return NetworkConstants.authLogin
        }
    }

    var method: Moya.Method {
        switch self {
        case .postUser:
            return .post
        }
    }

    var task: Moya.Task {
        switch self {
        case .postUser(let login, let password):
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
