//
//  Comment.swift
//  pandy
//
//  Created by Gleb Shendrik on 25.08.2020.
//

import Foundation

struct Comment: Codable {
    let id: Int
    let text: String
    let status: Status?
    let viewed: Int
    let moderatedCurrentUser: Bool?
    let user: User
    var _createdAt: String?
    var reaction: Reaction?
    var likesCount : Int
    var diskesCount : Int
    var currentUserLiked : Bool?
    
    var hasUserReaction : Bool {
        return currentUserLiked != nil
    }
    
    var userLiked : Bool {
        get {
            return currentUserLiked == true
        } set {
            if newValue {
                if currentUserLiked == true {
                    likesCount -= 1
                    currentUserLiked = nil
                } else if currentUserLiked == false {
                    likesCount += 1
                    currentUserLiked = true
                    diskesCount -= 1
                } else {
                    likesCount += 1
                    currentUserLiked = true
                }
            } else {
                likesCount -= 1
                currentUserLiked = nil
            }
        }
    }
    
    var userdisLiked : Bool {
        get {
            return currentUserLiked == false
        } set {
            if newValue {
                if currentUserLiked == false {
                    diskesCount -= 1
                    currentUserLiked = nil
                } else if currentUserLiked == true {
                    diskesCount += 1
                    likesCount -= 1
                    currentUserLiked = false

                } else {
                    diskesCount += 1
                    currentUserLiked = false
                }
            } else {
                diskesCount -= 1
                currentUserLiked = nil
            }
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id, text, status, viewed
        case moderatedCurrentUser = "moderated_current_user"
        case user
        case _createdAt = "created_at"
        case reaction
        case likesCount = "likes_cnt"
        case diskesCount = "dislikes_cnt"
        case currentUserLiked = "liked_current_user"
    }
    
    var defaultDateFormatter : DateFormatter {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        return dateFormater
    }
    
    var createdAt : Date {
        get{
            return defaultDateFormatter.date(from: _createdAt!) ?? Date()
        }
        set {
            _createdAt = defaultDateFormatter.string(from: newValue)
        }
    }
}
