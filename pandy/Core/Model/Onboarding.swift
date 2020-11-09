//
//  Onboarding.swift
//  pandy
//
//  Created by Gleb Shendrik on 09.09.2020.
//

import Foundation

struct OnboardingStep : Equatable {
    static func == (lhs: OnboardingStep, rhs: OnboardingStep) -> Bool {
        return lhs.type.rawValue == rhs.type.rawValue
    }
    
    var type : StepType
    var required : Bool
    var value : Any?
    
    mutating func setValue(_ value : Any?) {
        self.value = value
    }
    
    enum StepType : String {
        case aim, notifications, info, personSelection
    }
    
    var dictionary : [String : Any] {
        switch type {
        case .aim:
            if let aim = value as? Aim {
                return ["quiz" : ["target" : aim.rawValue]]
            }
            return [:]
        case .personSelection:
            if let data = value as? PersonModel {
                var dict = [String : Any]()
                dict["photo_id"] = data.avatar.id
                dict["name_first_id"] = data.name.firstID
                dict["name_last_id"] = data.name.lastID
                return dict
            }
            return [:]
        default:
            break
        }
        return [:]
    }
}
