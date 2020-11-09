//
//  NotificationListItem.swift
//  pandy
//
//  Created by Gleb Shendrik on 04.09.2020.
//

import Foundation


extension NotificationListItem : PayloadType { }

struct NotificationListItem: Codable, Equatable {
    
    static func == (lhs: NotificationListItem, rhs: NotificationListItem) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: Int
    let type: String
    let data: DataClass
    let isReaded: Int
    let createdAt: String
    
    var creationDate : Date {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        return dateFormater.date(from: createdAt) ?? Date()
    }
    
    var isRead : Bool {
        return isReaded == 1
    }
    
    enum CodingKeys: String, CodingKey {
        case id, type, data
        case isReaded = "is_readed"
        case createdAt = "created_at"
    }
    
    // MARK: - DataClass
    struct DataClass: Codable {
        let recordCommentID: String?
        let recordID: Int
        let user: User
        let recordTitle, recordCommentText: String
        
        enum CodingKeys: String, CodingKey {
            case recordCommentID = "record_comment_id"
            case recordID = "record_id"
            case user
            case recordTitle = "record_title"
            case recordCommentText = "record_comment_text"
        }
    }
}


