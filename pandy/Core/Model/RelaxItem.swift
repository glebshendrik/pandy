//
//  RelaxItem.swift
//  pandy
//
//  Created by Gleb Shendrik on 17.09.2020.
//

import Foundation


extension RelaxItem : PayloadType { }
// MARK: - Welcome
struct RelaxItem: Codable {
    let id: Int
    let title: String
    let sectID: Int
    let sectTitle, imageURL: String
    let lengthFrom, lengthTo: Int
    let allow: Bool
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case sectID = "sect_id"
        case sectTitle = "sect_title"
        case imageURL = "image_url"
        case lengthFrom = "length_from"
        case lengthTo = "length_to"
        case allow
    }
    
    var durationString : String {
        if lengthFrom == lengthTo {
            return L10n.Common.durationInMinutes(String(lengthFrom))
        } else {
            return L10n.Common.durationInMinutes(String(lengthFrom) + "-" + String(lengthTo))
        }
    }
}
