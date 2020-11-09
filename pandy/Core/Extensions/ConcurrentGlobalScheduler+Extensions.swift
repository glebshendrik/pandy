//
//  ConcurrentGlobalScheduler+Extensions.swift
//  eljur
//
//  Created by Gleb Shendrik on 25/09/2019.
//
//

import RxSwift

extension ConcurrentDispatchQueueScheduler {
    class var userInitiated : ConcurrentDispatchQueueScheduler {
        return ConcurrentDispatchQueueScheduler(qos: .userInitiated)
    }
    
    class var background : ConcurrentDispatchQueueScheduler {
        return ConcurrentDispatchQueueScheduler(qos: .background)
    }
    
    class var defaultScheduler : ConcurrentDispatchQueueScheduler {
        return ConcurrentDispatchQueueScheduler(qos: .default)
    }
}
