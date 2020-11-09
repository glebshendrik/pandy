//
//  Network.swift
//  pandy
//
//  Created by Gleb Shendrik on 29.06.2020.
//

import Foundation
import UIKit

extension NetworkItem : PayloadType { }

struct NetworkItem: Codable {
    let id: Int
    let _type, title: String
    var rating, likesCnt, viewsCnt: Int
    let createdAt: String
    var likedCurrentUser : Bool
    var commentModeratedCurrentUser: Bool?
    let firstPremoderatedComment: Comment?
    let showType: String?
    let commentsCnt: Int
    let text: String
    let dataArr: DataArr?
    let spheresArr: [String]?
    let user: User
    let comments: [Comment]?
    let likedIsers : [User]?
    
    var shperes : [LifeSphere] {
        return spheresArr?.compactMap({ $0 }).compactMap({ LifeSphere(rawValue : $0)}) ?? []
    }
    
    var type : EmotionType {
        return EmotionType(rawValue : _type) ?? .day
    }
    
    var creationDate : Date {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        return dateFormater.date(from: createdAt) ?? Date()
    }
    
    mutating func setLiked() {
        likedCurrentUser = true
        likesCnt += 1
    }
    
    mutating func removeLike() {
        likedCurrentUser = false
        if likesCnt > 0 {
            likesCnt -= 1
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id, title, rating
        case _type = "type"
        case likesCnt = "likes_cnt"
        case viewsCnt = "views_cnt"
        case createdAt = "created_at"
        case likedCurrentUser = "liked_current_user"
        case commentModeratedCurrentUser = "comment_moderated_current_user"
        case firstPremoderatedComment = "first_premoderated_comment"
        case showType = "show_type"
        case commentsCnt = "comments_cnt"
        case text
        case dataArr = "data_arr"
        case spheresArr = "spheres_arr"
        case likedIsers = "likes_users"
        case user, comments
    }
    
    struct DataArr: Codable {
        let change, conclusions, descr: String?
        let dayrate : Int?
        let expected, feel, firststep, dataArrFor: String?
        let happened, remember, to, what: String?
        
        enum CodingKeys: String, CodingKey {
            case change, conclusions, dayrate, descr, expected, feel, firststep
            case dataArrFor = "for"
            case happened, remember, to, what
        }
    }
    
    subscript(field: String) -> String? {
        switch field {
        case "change" :
            return dataArr?.change
        case "conclusions" :
            return dataArr?.conclusions
        case "descr" :
            return dataArr?.descr
        case "expected" :
            return dataArr?.expected
        case "feel" :
            return dataArr?.feel
        case "firststep" :
            return dataArr?.firststep
        case "for" :
            return nil
        case "happened" :
            return dataArr?.happened
        case "remember" :
            return dataArr?.remember
        case "to" :
            return dataArr?.to
        case "what" :
            return dataArr?.what
        default:
            return nil
        }
    }
}

extension NetworkItem {
    
    var emotionIcon : UIImage {
        switch type {
        case.day:
            switch dataArr?.dayrate ?? 0 {
            case 1 :
                return Images.dayRateTerribly.image
            case 2 :
                return Images.dayRateBad.image
            case 3 :
                return Images.dayRateNotVery.image
            case 4 :
                return Images.dayRateFine.image
            case 5 :
                return Images.dayRateWell.image
            case 6 :
                return Images.dayRateExcellent.image
            default:
                return Images.dayRateExcellent.image
            }
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
        default:
            return Images.testEmoImage.image
        }
    }
    
    var emotionColor : UIColor {
        switch type {
        case .day:
            switch dataArr?.dayrate ?? 0 {
            case 1 :
                return UIColor.color(from: "#FFDDDF")
            case 2 :
                return UIColor.color(from: "#FFE5C7")
            case 3 :
                return UIColor.color(from: "#FCF2CE")
            case 4 :
                return UIColor.color(from: "#D6E3FC")
            case 5 :
                return UIColor.color(from: "#CDF3D9")
            case 6 :
                return UIColor.color(from: "#CDF3D9")
            default:
                return UIColor.color(from: "#FFDDDF")
            }
        case .thanks, .insight, .wish, .kindliness:
            return UIColor.color(from: "#F0F5F9")
        case .emoFear, .emoBlame, .emoHurt, .emoShame, .emoAnger:
            switch rating {
            case 1...2:
                return UIColor.color(from: "#F0F5F9")
            case 3...4:
                return UIColor.color(from: "#D6E3FC")
            case 5...6:
                return UIColor.color(from: "#FCF2CE")
            case 7...8:
                return UIColor.color(from: "#FFE5C7")
            case 9...10:
                return UIColor.color(from: "#FFDDDF")
            default:
                return UIColor.color(from: "CDF3D9")
            }
        default:
            return UIColor.color(from: "D6E3FC")
        }
    }
    
    var progressColor : UIColor {
        switch type {
        case .day:
            return UIColor.clear
        case .thanks, .insight, .wish, .kindliness:
            return UIColor.color(from: "#F0F5F9")
        case .emoFear, .emoBlame, .emoHurt, .emoShame, .emoAnger:
            switch rating {
            case 1...2:
                return UIColor.color(from: "#A7C2F6")
            case 3...4:
                return UIColor.color(from: "#A7C2F6")
            case 5...6:
                return UIColor.color(from: "#F8E192")
            case 7...8:
                return UIColor.color(from: "#F9C384")
            case 9...10:
                return UIColor.color(from: "#F6B3B7")
            default:
                return UIColor.color(from: "CDF3D9")
            }
        default:
            return UIColor.color(from: "D6E3FC")
        }
    }
}




