//
//  DiaryNew.swift
//  pandy
//
//  Created by Gleb Shendrik on 11.09.2020.
//

import Foundation

struct DiaryNew: Codable {
    
    internal init(type: String = "", title: String = "", dayrate: String = "", diaryNewPublic: Bool = true, remember: String = "", conclusions: String = "", spheresArr: [String] = [], to: String = "", diaryNewFor: String = "", what: String = "", change: String = "", feel: String = "", firststep: String = "", rating: String = "", image: String = "", happened: String = "", descr: String = "", expected: String = "") {
        self.type = type
        self.title = title
        self.dayrate = dayrate
        self.diaryNewPublic = diaryNewPublic
        self.remember = remember
        self.conclusions = conclusions
        self.spheresArr = spheresArr
        self.to = to
        self.diaryNewFor = diaryNewFor
        self.what = what
        self.change = change
        self.feel = feel
        self.firststep = firststep
        self.rating = rating
        self.image = image
        self.happened = happened
        self.descr = descr
        self.expected = expected
    }
    
    var type, title, dayrate: String
    var diaryNewPublic: Bool
    var remember, conclusions: String
    var spheresArr: [String]
    var to, diaryNewFor, what, change: String
    var feel, firststep, rating, image: String
    var happened, descr, expected: String

    
    
    enum CodingKeys: String, CodingKey {
        case type
        case diaryNewPublic = "public"
        case title, dayrate, remember, conclusions
        case spheresArr = "spheres_arr"
        case to
        case diaryNewFor = "for"
        case what, change, feel, firststep, rating, image, happened, descr, expected
    }
}

struct DiaryNewResponse: Codable {
    let status: String
    let data: DataClass
}

struct DataClass: Codable {
    let id, recordSectID, type, title: String
    let text: String
    let dataArr: DataArr
    let imageURL, dataPublic, rating, likesCnt: String
    let viewsCnt, worksCnt: String
    let spheresArr: [String]
    let commentsUnviewedCnt, commentsCnt, createdAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case recordSectID = "record_sect_id"
        case type, title, text
        case dataArr = "data_arr"
        case imageURL = "image_url"
        case dataPublic = "public"
        case rating
        case likesCnt = "likes_cnt"
        case viewsCnt = "views_cnt"
        case worksCnt = "works_cnt"
        case spheresArr = "spheres_arr"
        case commentsUnviewedCnt = "comments_unviewed_cnt"
        case commentsCnt = "comments_cnt"
        case createdAt = "created_at"
    }
}

// MARK: - DataArr
struct DataArr: Codable {
    let change, conclusions, dayrate, descr: String
    let expected, feel, firststep, dataArrFor: String
    let happened, remember, to, what: String

    enum CodingKeys: String, CodingKey {
        case change, conclusions, dayrate, descr, expected, feel, firststep
        case dataArrFor = "for"
        case happened, remember, to, what
    }
}
