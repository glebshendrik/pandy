//
//  SortOrder.swift
//  pandy
//
//  Created by Gleb Shendrik on 03.08.2020.
//

import Foundation

enum SortOrder : String {
    case id = "id"
    case rating = "rating"
    
    var title : String {
        switch self {
        case .id:
            return L10n.Sort.newOnesButtonTitle
        case .rating:
            return L10n.Sort.relevatOnesButtonTitle
        }
    }
}
