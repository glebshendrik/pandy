//
//  PersonModel.swift
//  pandy
//
//  Created by Gleb Shendrik on 12.09.2020.
//

import Foundation

struct PersonModel {
    var avatar : AvatarModel
    var name : NameModel
    var sex : Sex
    
    var dict : [String : Any] {
        var dict = [String : Any]()
        if avatar.id != -1 {
            dict["photo_id"] = avatar.id
        }
        if name.firstID != -1 {
            dict["name_first_id"] = name.firstID
        }
        if name.lastID != -1 {
            dict["name_last_id"] = name.lastID
        }
        return dict
    }
}
