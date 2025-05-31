//
//  Data+StringAppend.swift
//  Asset Management
//
//  Created by Supriyo Dey on 08/12/23.
//

import Foundation

extension Data {
   mutating func append(_ string: String) {
      if let data = string.data(using: .utf8) {
         append(data)
//         print("data======>>>",data)
      }
   }
}
