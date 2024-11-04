//
//  UserTokenModel.swift
//  TransportSchedule
//
//  Created by Alexander Ognerubov on 03.11.2024.
//

import Foundation

struct UserTokenModel: Decodable {
    let token: String
    let tokenLifetime: Int
}
