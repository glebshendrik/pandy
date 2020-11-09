//
//  Data+Extansions.swift
//  Eshka
//
//  Created by Gleb Shendrik on 30/08/2019.
//
//

import Foundation

extension Data {
    var stringRepresentation : String {
        return String(data: self, encoding: .utf8) ?? "not a string"
    }
}
