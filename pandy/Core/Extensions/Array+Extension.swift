//
//  Array+Extension.swift
//  Eshka
//
//  Created by Gleb Shendrik on 05/09/2019.
//
//

import Foundation

extension Array where Element:Equatable {
    func removeDuplicates() -> [Element] {
        var result = [Element]()
        
        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }
        
        return result
    }
}
