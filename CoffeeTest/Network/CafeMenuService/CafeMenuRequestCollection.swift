//
//  CafeMenuRequestCollection.swift
//  CoffeeTest
//
//  Created by Alexander Ognerubov on 04.11.2024.
//

import Foundation
import Moya

enum CafeMenuRequestCollection {
    case getCafeMenu(token: String, id: Int)
}

extension CafeMenuRequestCollection: TargetType {
    var baseURL: URL { URL(string: NetworkConstants.baseUrl) ?? URL(filePath: "") }

    var path: String {
        switch self {
        case .getCafeMenu(_, let id):
            return "\(NetworkConstants.location)/\(id)\(NetworkConstants.menu)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getCafeMenu:
            return .get
        }
    }

    var task: Moya.Task {
        switch self {
        case .getCafeMenu:
            return .requestPlain
        }
    }

    var headers: [String : String]? {
        switch self {
        case .getCafeMenu(let token, _):
            return [
                NetworkConstants.accept: NetworkConstants.applicationJson,
                NetworkConstants.authorization: token
            ]
        }
    }
}
