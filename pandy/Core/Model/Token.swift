//
//  Token.swift
//  pandy
//
//  Created by Gleb Shendrik on 17.08.2020.
//

import Foundation

extension Token : PayloadType { }

struct Token: Codable {
    
    let token : String
    let userID: Int?
    
    enum CodingKeys: String, CodingKey {
        case token
        case userID = "user_id"
    }
}
