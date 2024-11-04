//
//  MenuItemsModel.swift
//  CoffeeTest
//
//  Created by Alexander Ognerubov on 01.11.2024.
//

import Foundation

struct MenuItemsModel: Identifiable, Decodable {
    let id: Int
    let name: String
    let price: Int
    let imageURL: URL
}
