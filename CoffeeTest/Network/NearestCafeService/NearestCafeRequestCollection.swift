//
//  NearestCafeRequestCollection.swift
//  CoffeeTest
//
//  Created by Alexander Ognerubov on 03.11.2024.
//

import Foundation
import Moya

enum NearestCafeRequestCollection {
    case getNearestCafes(token: String)
}

extension NearestCafeRequestCollection: TargetType {
    var baseURL: URL { URL(string: NetworkConstants.baseUrl) ?? URL(filePath: "") }

    var path: String {
        switch self {
        case .getNearestCafes:
            return NetworkConstants.locations
        }
    }

    var method: Moya.Method {
        switch self {
        case .getNearestCafes:
            return .get
        }
    }

    var task: Moya.Task {
        switch self {
        case .getNearestCafes:
            return .requestPlain
        }
    }

    var headers: [String : String]? {
        switch self {
        case .getNearestCafes(let token):
            return [
                NetworkConstants.accept: NetworkConstants.applicationJson,
                NetworkConstants.authorization: token
            ]
        }
    }
}
