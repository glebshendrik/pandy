//
//  RuntimeError.swift
//  Eshka
//
//  Created by Gleb Shendrik on 19/09/2019.
//
//

import Foundation

struct RuntimeError: Swift.Error, LocalizedError  {
    let message: String
    
    init(_ message: String) {
        self.message = message
    }
    
    var errorDescription: String? {
        return message
    }
    
    public var localizedDescription: String {
        return message
    }
}
