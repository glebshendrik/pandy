//
//  Aim.swift
//  pandy
//
//  Created by Gleb Shendrik on 07.09.2020.
//

import Foundation


enum Aim : Int {
    case copeStress, menageEmotions, understandYouself, learn, justWantToSee
    
    var title : String {
        switch self {
        case .copeStress:
            return L10n.Aim.copeStress
        case .menageEmotions:
            return L10n.Aim.menageEmotions
        case .understandYouself:
            return L10n.Aim.understandYouself
        case .learn:
            return L10n.Aim.learn
        case .justWantToSee:
            return L10n.Aim.justWantToSee
        }
    }
    
    var text : String {
        switch self {
        case .copeStress:
            return L10n.Aim.copeStressText
        case .menageEmotions:
            return L10n.Aim.manageEmotionsText
        case .understandYouself:
            return L10n.Aim.understandYouselfText
        case .learn:
            return L10n.Aim.learnText
        case .justWantToSee:
            return L10n.Aim.justWantToSeeText
        }
    }
    
    static var aims : [Aim] {
        return [copeStress, menageEmotions, understandYouself, learn, justWantToSee]
    }
}
