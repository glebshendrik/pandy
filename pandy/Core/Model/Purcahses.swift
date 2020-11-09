//
//  Purcahses.swift
//  pandy
//
//  Created by Gleb Shendrik on 17.08.2020.
//

import Foundation

protocol Purchsable {
    var id : String { get }
}

enum Subscription : String, Purchsable {
    case monthSubscription = "ru.pandy.pandyappios.month_subscription1"
    case yearSubscription = "ru.pandy.pandyappios.year_subscription1"
    
    var id: String {
        return self.rawValue
    }
    
    static var all : [Subscription] {
        return [monthSubscription, yearSubscription]
    }
}

struct SubscriptionState: Codable {
    var activeProductId: String?
    var expireDate: Date?
    var subscribed: Bool { return self.activeProductId != nil }
}

enum Course : String, Purchsable {
    case firstCorse = "ru.pandy.pandyappios.first_course"
    
    var id: String {
        return self.rawValue
    }
    
    static var all : [Course] {
        return [firstCorse]
    }
}
