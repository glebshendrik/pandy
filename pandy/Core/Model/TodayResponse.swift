//
//  TodayResponse.swift
//  pandy
//
//  Created by Gleb Shendrik on 19.09.2020.
//

import Foundation

struct TodayResponse: PayloadType {
    let tasks: [TaskItem]
    let relax : [RelaxItem]
}
