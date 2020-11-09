//
//  AvatarModel.swift
//  pandy
//
//  Created by Gleb Shendrik on 08.09.2020.
//

import Foundation

struct AvatarModel: Codable {
    let id: Int
    let url: String
    var inPriority : Bool? = false
}
