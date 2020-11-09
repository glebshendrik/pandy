//
//  Observable+Extensions.swift
//  eljur
//
//  Created by Gleb Shendrik on 24/09/2019.
//
//

import RxSwift
import RxCocoa

extension ObservableType {
    
    func asDriverOnErrorJustComplete() -> Driver<Element> {
        return asDriver { _ in
            return Driver.empty()
        }
    }
    
    func mapToVoid() -> Observable<Void> {
        return map { _ in }
    }
}

extension PrimitiveSequenceType where Trait == SingleTrait {
    func asDriverOnErrorJustComplete() -> Driver<Element> {
        return self.primitiveSequence.asDriver { _ in
            return Driver.empty()
        }
    }
}
