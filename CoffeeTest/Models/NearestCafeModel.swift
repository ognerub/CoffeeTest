//
//  NearestCafeModel.swift
//  CoffeeTest
//
//  Created by Alexander Ognerubov on 01.11.2024.
//

import Foundation

struct NearestCafeModel: Identifiable, Decodable, Equatable {
    let id: Int
    let name: String
    let point: NearestCafePoint
    let distance: String?
}

struct NearestCafePoint: Decodable, Equatable {
    let latitude: String
    let longitude: String
}
