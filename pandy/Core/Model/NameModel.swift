//
//  NameModel.swift
//  pandy
//
//  Created by Gleb Shendrik on 08.09.2020.
//

import Foundation

struct NameModel: Codable {
    let firstID, lastID: Int
    let text: String
    var inPriority : Bool? = false
    
    enum CodingKeys: String, CodingKey {
        case firstID = "first_id"
        case lastID = "last_id"
        case text
    }
}
