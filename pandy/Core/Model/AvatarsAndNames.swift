//
//  AvatarsAndName.swift
//  pandy
//
//  Created by Gleb Shendrik on 09.09.2020.
//

import Foundation

struct AvatarsAndNames : PayloadType {
    let photos : [AvatarModel]
    let names : [NameModel]
}
