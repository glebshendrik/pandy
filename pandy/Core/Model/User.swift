//
//  User.swift
//  pandy
//
//  Created by Gleb Shendrik on 17.08.2020.
//

import Foundation

struct User: Codable {
    let id, avatarID: Int
    let nameFirst, nameLast: String
    let photoURL: String
    let languageCode: String
    let sex : String?
    
    var fullName : String {
        return nameFirst + " " + nameLast
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case avatarID = "avatar_id"
        case sex
        case nameFirst = "name_first"
        case nameLast = "name_last"
        case photoURL = "photo_url"
        case languageCode = "language_code"
    }
}

struct UserDetail: Codable {
    let id, avatarID: Int?
    let sex, nameFirst, nameLast: String?
    let photoURL: String?
    let languageCode: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case avatarID = "avatar_id"
        case sex
        case nameFirst = "name_first"
        case nameLast = "name_last"
        case photoURL = "photo_url"
        case languageCode = "language_code"
    }
}
