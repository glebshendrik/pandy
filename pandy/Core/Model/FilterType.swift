//
//  FilterType.swift
//  pandy
//
//  Created by Gleb Shendrik on 31.07.2020.
//

import Foundation

enum FilterType : String {
    
    case emotionTypes = "type"
    case lifeSpheres = "sphere"
    
    var title : String {
        switch self {
        case .emotionTypes:
            return L10n.Filter.recordsTypesTabTitle
        case.lifeSpheres:
            return L10n.Filter.spheresOfLifeTabTitle
        }
    }
}
