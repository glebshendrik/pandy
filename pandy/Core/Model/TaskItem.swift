//
//  TaskItem.swift
//  pandy
//
//  Created by Gleb Shendrik on 17.09.2020.
//

import Foundation

struct TaskItem: Codable {
    
    enum Status : String {
        case available, completed, taked, forbidden
    }
    
    let id: Int
    let type, title, taskDescription: String
    let reward: Int
    let ico: String
    let _status: String
    
    var status : Status {
        return Status(rawValue: _status) ?? .available
    }
    
    enum CodingKeys: String, CodingKey {
        case id, type, title
        case taskDescription = "description"
        case reward, ico
        case _status = "status"
    }
}
