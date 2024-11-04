//
//  String+Extension.swift
//  CoffeeTest
//
//  Created by Alexander Ognerubov on 31.10.2024.
//

import Foundation

extension String {

  var localized: String {
    return NSLocalizedString(self, comment: "\(self)_comment")
  }

  func localized(_ args: CVarArg...) -> String {
    return String(format: localized, args)
  }
}
