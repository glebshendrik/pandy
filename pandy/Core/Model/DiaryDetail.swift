//
//  DiaryDetails.swift
//  pandy
//
//  Created by Gleb Shendrik on 25.08.2020.
//

import Foundation

struct DiaryDetail: Codable {
    let status: String
    let data: DataClass
    let notificationsCount, karmaCount: Int
    
    enum CodingKeys: String, CodingKey {
        case status, data
        case notificationsCount = "notifications_count"
        case karmaCount = "karma_count"
    }
    
    struct DataArr: Codable {
        let dayrate: Int
        let remember, conclusions: String
    }

    
    struct DataClass: Codable {
        let id: Int
        let type: String
        let recordSectID: Int
        let title: String
        let dataPublic, rating, likesCnt, viewsCnt: Int
        let worksCnt: Int
        let createdAt: String
        let commentsUnviewedCnt: Int
        let likesUsers: [User]
        let commentsCnt: Int
        let text: String
        let dataArr: DataArr
        let imageURL: String
        let comments: [Comment]
        
        enum CodingKeys: String, CodingKey {
            case id, type
            case recordSectID = "record_sect_id"
            case title
            case dataPublic = "public"
            case rating
            case likesCnt = "likes_cnt"
            case viewsCnt = "views_cnt"
            case worksCnt = "works_cnt"
            case createdAt = "created_at"
            case commentsUnviewedCnt = "comments_unviewed_cnt"
            case likesUsers = "likes_users"
            case commentsCnt = "comments_cnt"
            case text
            case dataArr = "data_arr"
            case imageURL = "image_url"
            case comments
        }
    }
}

struct DeleteResponse: Codable {
    let status: String
    let notificationsCount, karmaCount: Int

    enum CodingKeys: String, CodingKey {
        case status
        case notificationsCount = "notifications_count"
        case karmaCount = "karma_count"
    }
}


