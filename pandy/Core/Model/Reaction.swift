//
//  Reaction.swift
//  pandy
//
//  Created by Gleb Shendrik on 20.08.2020.
//

import Foundation

struct ReactionResponse: Codable {
    let status, data: String
    let notificationsCount, karmaCount: Int

    enum CodingKeys: String, CodingKey {
        case status, data
        case notificationsCount = "notifications_count"
        case karmaCount = "karma_count"
    }
}


struct Reaction: Codable {
    var _result: String?
    let karmacnt: Int?
    
    enum CodingKeys: String, CodingKey {
        case _result = "result"
        case karmacnt = "karma_cnt"
    }
    
    var result : EmotionType {
        get {
            return EmotionType(rawValue : _result!) ?? .day
        }
        set {
            _result = newValue.rawValue
        }
    }
}
