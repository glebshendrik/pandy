//
//  DiaryDetailScheme.swift
//  pandy
//
//  Created by Gleb Shendrik on 23.08.2020.
//

import Foundation

// MARK: - DiaryDetailScheme
struct DiaryDetailScheme: Codable {
    let day: Day?
    let good: Good
    let bad: Bad
}

// MARK: - Bad
struct Bad: Codable {
    let emoHurt, emoBlame, emoShame, emoFear: Day?
    let emoAnger: Day?

    enum CodingKeys: String, CodingKey {
        case emoHurt = "emo-hurt"
        case emoBlame = "emo-blame"
        case emoShame = "emo-shame"
        case emoFear = "emo-fear"
        case emoAnger = "emo-anger"
    }
}

// MARK: - Day
struct Day: Codable {
    let ico: Ico
    let title: String
    let fields: [Field]
}

// MARK: - Field
struct Field: Codable {
    let name: String
    let type: TypeEnum
    let fieldRequired: Int?
    let title: String
    let fieldDescription: String?
    let show, reuired: Int?
    let values: [Value]?

    enum CodingKeys: String, CodingKey {
        case name, type
        case fieldRequired = "required"
        case title
        case fieldDescription = "description"
        case show, reuired, values
    }
}

enum TypeEnum: String, Codable {
    case list = "list"
    case paint = "paint"
    case rangePicker = "range_picker"
    case textarea = "textarea"
    case textareaWithTitle = "textarea_with_title"
}

// MARK: - Value
struct Value: Codable {
    let name, title: String
}

enum Ico: String, Codable {
    case xxxIco = "xxx.ico"
}

// MARK: - Good
struct Good: Codable {
    let thanks, kindliness, wish, insight: Day?
}

