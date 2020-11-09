//
//  Dictionary+Extensions.swift
//  Asha
//
//  Created by Gleb Shendrik on 23/07/2019.
//
//

import Foundation

extension Dictionary {
    mutating func update(other:Dictionary) {
        for (key,value) in other {
            self.updateValue(value, forKey:key)
        }
    }
}
