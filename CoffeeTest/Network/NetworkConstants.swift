//
//  NetworkConstants.swift
//  CoffeeTest
//
//  Created by Alexander Ognerubov on 03.11.2024.
//

import Foundation

struct NetworkConstants {
    static let baseUrl = "http://147.78.66.203:3210"
    static let authRegister = "/auth/register"
    static let authLogin = "/auth/login"
    static let locations = "/locations"
    static let location = "/location"
    static let menu = "/menu"
    static let authorization = "Authorization"
    static let accept = "accept"
    static let contentType = "Content-Type"
    static let applicationJson = "application/json"
    static let login = "login"
    static let password = "password"
    static let bearerToken = "bearerToken"
    static let tokenExpireInterval = "tokenExpireInterval"
}
