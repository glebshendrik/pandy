//
//  Profile.swift
//  pandy
//
//  Created by Gleb Shendrik on 14.09.2020.
//

import Foundation

extension Profile : PayloadType { }

struct Profile: Codable {
    
    let id: Int
    let activationStatus: String
    let karma: Int
    let _sex, nameFirst, nameLast: String?
    let photoURL: String?
    let languageCode: String?
    let languagesCode: [String]?
    var isLinkedAppleAccount : Bool
    var isLinkedGoogleAccount : Bool
    let isQuizPassed : Bool
    let isSubscribed : Bool
    
    var sex : Sex {
        return Sex(rawValue: _sex ?? "") ?? .male
    }
    
    var fullName : String {
        return (nameFirst ?? "") + " " + (nameLast ?? "")
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case activationStatus = "activation_status"
        case karma, _sex
        case nameFirst = "name_first"
        case nameLast = "name_last"
        case photoURL = "photo_url"
        case languageCode = "language_code"
        case languagesCode = "languages_code"
        case isLinkedAppleAccount = "is_linked_account_apple"
        case isLinkedGoogleAccount = "is_linked_account_google"
        case isQuizPassed = "is_quiz_passed"
        case isSubscribed = "has_subscribe"
    }
    
}
