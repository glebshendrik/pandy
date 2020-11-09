//
//  EmotionType.swift
//  pandy
//
//  Created by Gleb Shendrik on 30.07.2020.
//

import UIKit

enum EmotionType : String {
    case all = "all"
    case allBad = "all-bad"
    case allGood = "all-good"
    case day = "day"
    case thanks = "thanks"
    case insight = "insight"
    case wish = "wish"
    case kindliness = "kindliness"
    case emoFear = "emo-fear"
    case emoBlame = "emo-blame"
    case emoHurt = "emo-hurt"
    case emoShame = "emo-shame"
    case emoAnger = "emo-anger"
    case emoHeartface = "verygood"
    case emoAirkiss = "good"
    case emoFacewithsteam = "bad"
    case emoSwearingface = "verybad"
    
    
//    verygood, good, bad, verybad
}

extension EmotionType {
    var icon : UIImage {
        switch self {
        case .insight:
            return Images.emoInsightIcon.image
        case .kindliness:
            return Images.emoKindlinessIcon.image
        case .thanks:
            return Images.emoThanksIcon.image
        case .wish:
            return Images.emoWishIcon.image
        case .emoFear:
            return Images.emoFearIcon.image
        case .emoHurt:
            return Images.emoHurtIcon.image
        case .emoAnger:
            return Images.emoAngerIcon.image
        case .emoBlame:
            return Images.emoBlameIcon.image
        case .emoShame:
            return Images.emoShameIcon.image
        case .day:
            return Images.addDayRecordIconActive.image
        case .emoHeartface:
            return Images.emoHeartfaceIcon.image
        case .emoAirkiss:
            return Images.emoAirkissIcon.image
        case .emoFacewithsteam:
            return Images.emoFacewithsteamIcon.image
        case .emoSwearingface:
            return Images.emoSwearingfaceIcon.image
        default:
            return Images.testEmoImage.image
        }
    }
    var title : String {
        switch self {
        case .day:
            return L10n.Category.all
        case .all:
            return L10n.Category.all
        case .allGood:
            return L10n.Category.allGood
        case .allBad:
            return L10n.Category.allBad
        case .thanks:
            return L10n.EmotionType.thanksTitle
        case .insight:
            return L10n.EmotionType.insightTitle
        case .wish:
            return L10n.EmotionType.wishTitle
        case .kindliness:
            return L10n.EmotionType.kindlinessTitle
        case .emoFear:
            return L10n.EmotionType.emoFearTitle
        case .emoHurt:
            return L10n.EmotionType.emoHurtTitle
        case .emoShame:
            return L10n.EmotionType.emoShameTitle
        case .emoAnger:
            return L10n.EmotionType.emoAngerTitle
        case .emoBlame:
            return L10n.EmotionType.emoBlameTitle
        case .emoHeartface:
            return L10n.EmotionType.emoHeartfaceTitle
        case .emoAirkiss:
            return L10n.EmotionType.emoAirkissTitle
        case .emoFacewithsteam:
            return L10n.EmotionType.emoFacewithsteamTitle
        case .emoSwearingface:
            return L10n.EmotionType.emoSwearingfaceTitle
        }
    }
}
