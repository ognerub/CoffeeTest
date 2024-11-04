//
//  Mocks.swift
//  CoffeeTest
//
//  Created by Alexander Ognerubov on 01.11.2024.
//

import Foundation

public enum Mocks {
    static let cafes = [
        NearestCafeModel(id: 1, name: "Coffee Like", point: NearestCafePoint(latitude: "", longitude: ""), distance: "1 km from you"),
        NearestCafeModel(id: 2, name: "BEDOEV COFFEE", point: NearestCafePoint(latitude: "", longitude: ""),distance: "2 km from you"),
        NearestCafeModel(id: 3, name: "EM&DI Coffee and Snacks", point: NearestCafePoint(latitude: "", longitude: ""),distance: "3 km from you")
        ]

    static let menuItems = [
        MenuItemsModel(id: 1, name: "Espresso", price: 200, imageURL: URL(string: "01")!),
        MenuItemsModel(id: 2, name: "Capuchino", price: 200, imageURL: URL(string: "02")!),
        MenuItemsModel(id: 3, name: "Hot choco", price: 200, imageURL: URL(string: "03")!),
        MenuItemsModel(id: 4, name: "Latte", price: 200, imageURL: URL(string: "04")!)
    ]
}
