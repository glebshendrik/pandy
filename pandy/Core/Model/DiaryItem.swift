//
//  DiaryItem.swift
//  pandy
//
//  Created by Gleb Shendrik on 25.06.2020.
//

import Foundation
import SwiftyJSON

extension DiaryItem : PayloadType { }

struct DiaryItem : Codable {
    var id: Int
    var _type: String
    var recordSectionId: Int
    var title: String
    var _public, rating, likesCount, viewsCount: Int
    var worksCount: Int
    var _createdAt: String
    var commentsUnviewedCount, commentsCount: Int
    var text: String
    var dataArr: DataArr?
    var spheresArr: [String]?
    var _linekedRecordTypes : [String]?
    var imageURL: String
    var image : String?
    var resolved : Int?
    var comments: [Comment]?
    var likesUsers: [UserDetail]?
    
    struct DataArr: Codable {
        let dayrate: Int?
        let remember, conclusions: String?
        let happened, descr, expected: String?
        let what, change: String?
    }

    enum CodingKeys: String, CodingKey {
        case id
        case _type = "type"
        case recordSectionId = "record_sect_id"
        case title
        case _public = "public"
        case rating
        case likesCount = "likes_cnt"
        case viewsCount = "views_cnt"
        case worksCount = "works_cnt"
        case _createdAt = "created_at"
        case commentsUnviewedCount = "comments_unviewed_cnt"
        case commentsCount = "comments_cnt"
        case text
        case dataArr = "data_arr"
        case spheresArr = "spheres_arr"
        case imageURL = "image_url"
        case image = "image"
        case resolved = "resolved"
        case _linekedRecordTypes = "linked_records_types"
        case comments
        case likesUsers = "likes_users"
    }
    
    var linkedRecordsTypes : [EmotionType] {
        get {
            return _linekedRecordTypes?.compactMap({ EmotionType(rawValue: $0)}) ?? []
        }
        set {
            _linekedRecordTypes = newValue.compactMap({ $0.rawValue })
        }
    }
    var type : EmotionType {
        get {
            return EmotionType(rawValue : _type) ?? .day
        }
        set {
            _type = newValue.rawValue
        }
    }
    var defaultDateFormatter : DateFormatter {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        return dateFormater
    }
    
    var createdAt : Date {
        get{
            return defaultDateFormatter.date(from: _createdAt) ?? Date()
        }
        set {
            _createdAt = defaultDateFormatter.string(from: newValue)
        }
    }
    
    var isPublic : Bool {
        get {
            return _public > 0
        }
        set {
            _public = newValue ? 1 : 0
        }
    }
    
    var fetchingType : String = ""
    
    var fetchId : String {
        return String(id) + fetchingType
    }
}

// Presentation values
extension DiaryItem {
    var icon : UIImage {
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
    
    var imageColor : UIColor {
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




