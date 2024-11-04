//
//  TokenManager.swift
//  CoffeeTest
//
//  Created by Alexander Ognerubov on 03.11.2024.
//

import Foundation
import SwiftKeychainWrapper

final class TokenManager: ObservableObject {
    @Published var token: String?
    private var tokenExpireInterval: String?
    private let keychainWrapper = KeychainWrapper.standard

    init(token: String? = nil, tokenExpireInterval: String? = nil) {
        if token == nil {
            self.token = keychainWrapper.string(forKey: NetworkConstants.bearerToken)
            self.tokenExpireInterval = keychainWrapper.string(forKey: NetworkConstants.tokenExpireInterval)
        } else {
            self.token = token
            self.tokenExpireInterval = tokenExpireInterval
        }
    }

    func clearToken() {
        token = nil
        keychainWrapper.removeAllKeys()
    }

    func checkToken() -> Bool {
        if let interval = tokenExpireInterval, let rounded = Double(interval) {
            let currentDate = Date()
            let expireDate = Date(timeIntervalSince1970: TimeInterval(Int(rounded.rounded(.down))))
            if currentDate > expireDate {
                return false
            } else {
                return true
            }
        } else {
            return false
        }
    }

    func store(token: String, interval: Int) {
        self.token = token
        keychainWrapper.set(token, forKey: NetworkConstants.bearerToken)
        setTokenExpire(interval: interval)
    }

    private func setTokenExpire(interval: Int) {
        let currentDate = Date()
        let calendar = Calendar.current
        let expireDate = calendar.date(byAdding: .second, value: interval, to: currentDate)
        if let expireDateInTimeInterval = expireDate?.timeIntervalSince1970 {
            keychainWrapper.set(String(expireDateInTimeInterval), forKey: NetworkConstants.tokenExpireInterval)
            self.tokenExpireInterval = String(expireDateInTimeInterval)
        }
    }
}
