//
//  Utils.swift
//  Codic
//
//  Created by Tomoya Hirano on 2016/07/17.
//  Copyright © 2016年 Tomoya Hirano. All rights reserved.
//

import Foundation

extension Dictionary where Key: StringLiteralConvertible, Value: StringLiteralConvertible {
  func toQuery() -> String {
    let parameterArray = self.map { (key, value) -> String in
      guard let key = key as? String else { return "" }
      guard let value = value as? String else { return "" }
      guard let percentEscapedKey = key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return "" }
      guard let percentEscapedValue = value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return "" }
      return "\(percentEscapedKey)=\(percentEscapedValue)"
    }
    return parameterArray.joined(separator: "&")
  }
}
