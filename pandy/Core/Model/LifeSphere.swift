//
//  LifeSphere.swift
//  pandy
//
//  Created by Gleb Shendrik on 30.07.2020.
//

import UIKit

enum LifeSphere : String {
    
    case hobby = "hobby"
    case development = "development"
    case health = "health"
    case family = "family"
    case personalLife = "personallife"
    case job = "job"
    case environment = "environment"
    case finance = "finance"
    case recreation = "recreation"
    case comfort = "comfort"
    case myself = "myself"
    case people = "people"
    case world = "world"
    
    var icon : UIImage {
        switch self {
        case .hobby:
            return Images.hobbyIcon.image
        case .development:
            return Images.developmentIcon.image
        case .health:
            return Images.healthIcon.image
        case .family:
            return Images.familyIcon.image
        case .personalLife:
            return Images.personalIcon.image
        case .job:
            return Images.jobIcon.image
        case .environment:
            return Images.enviromentIcon.image
        case .finance:
            return Images.financeIcon.image
        case .recreation:
            return Images.recreationIcon.image
        case .comfort:
            return Images.comfortIcon.image
        case .myself:
            return Images.myselfIcon.image
        case .people:
            return Images.peopleIcon.image
        case .world:
            return Images.worldIcon.image
        }
        
    }
    
    var title : String {
        switch self {
        case .hobby:
            return L10n.LifeSphere.hobbyTitle
        case .development:
            return L10n.LifeSphere.developmentTitle
        case .health:
            return L10n.LifeSphere.healthTitle
        case .family:
            return L10n.LifeSphere.familyTitle
        case .personalLife:
            return L10n.LifeSphere.personallifeTitle
        case .job:
            return L10n.LifeSphere.jobTitle
        case .environment:
            return L10n.LifeSphere.environmentTitle
        case .finance:
            return L10n.LifeSphere.financeTitle
        case .recreation:
            return L10n.LifeSphere.recreationTitle
        case .comfort:
            return L10n.LifeSphere.comfortTitle
        case .myself:
            return L10n.LifeSphere.myselfTitle
        case .people:
            return L10n.LifeSphere.peopleTitle
        case .world:
            return L10n.LifeSphere.worldTitle
        }
        
    }
}
