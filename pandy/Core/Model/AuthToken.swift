//
//  AuthToken.swift
//  pandy
//
//  Created by Gleb Shendrik on 14.08.2020.
//

import Foundation

enum AuthToken {
    case google(idToken : String)
    case apple(identityToken : String)
    
    var name : String {
        switch self {
        case .google:
            return "google"
        case .apple:
            return "apple"
        }
    }
}
