//
//  SubscriptionVM.swift
//  pandy
//
//  Created by Gleb Shendrik on 15.09.2020.
//
import RxSwift
import RxCocoa
import StoreKit

class SubscriptionVM: ViewModelType {
    
    let disposeBag = DisposeBag()
    
    private let isLoadingRelay = BehaviorRelay<Bool>(value: false)
    private let oneMonthSubscriptionRelay = BehaviorRelay<SKProduct?>(value: nil)
    private let oneYearSubscriptionRelay = BehaviorRelay<SKProduct?>(value: nil)
    private let reloadSubject = PublishSubject<Void>()
    private let stateSubject = PublishSubject<ControllerState>()
    private let errorOccuredSubject = PublishSubject<String>()
    
    private let didSubscribeSubject = PublishSubject<Void>()
    
    required init(dependency: SubscriptionVM.Dependency, bindings: SubscriptionVM.Bindings) {
        let activityTracker = ActivityIndicator()
        let loadEvent = Observable<Void>.merge([Observable<Void>.just(()),
                                                       reloadSubject.asObservable()])
        
        let productsRequest = loadEvent.flatMapLatest({
            dependency.appStoreService
                .retriveSubscriptionsInfo()
                .asObservable()
                .materialize()
                .trackActivity(activityTracker)
        }).share()
        
        productsRequest.elements().mapTo(ControllerState.loaded).bind(to: stateSubject).disposed(by: disposeBag)
        productsRequest.errors().mapTo(ControllerState.error).bind(to: stateSubject).disposed(by: disposeBag)
        productsRequest.errors()
            .map({$0.localizedDescription})
            .bind(to: errorOccuredSubject)
            .disposed(by: disposeBag)
            
        productsRequest.elements().map({ products in
            products.filter({
                $0.productIdentifier == Subscription.monthSubscription.rawValue
            })
            .first
            })
            .compactMap({ $0 })
            .bind(to: oneMonthSubscriptionRelay)
            .disposed(by: disposeBag)
        productsRequest.elements().map({ products in
            products.filter({
                $0.productIdentifier == Subscription.yearSubscription.rawValue
            })
            .first
            })
            .compactMap({ $0 })
            .bind(to: oneYearSubscriptionRelay)
            .disposed(by: disposeBag)
        
        bindings.didPressContinueForFree.drive(onNext : {[weak self]  in
            self?.didSubscribeSubject.onNext(())
        }).disposed(by: disposeBag)
        
        activityTracker.asObservable().bind(to: isLoadingRelay).disposed(by: disposeBag)
    }
    
    struct Dependency {
        let appStoreService : AppStoreService
        let userService : UserService
    }
    
    struct Bindings {
        let didPressContinueForFree : Driver<Void>
    }
}

// Router output
extension SubscriptionVM {
    var didSubscribe : Driver<Void> {
        didSubscribeSubject.asDriverOnErrorJustComplete()
    }
}

// View output
extension SubscriptionVM {
    var state : Driver<ControllerState> {
        return stateSubject.asDriverOnErrorJustComplete()
    }
    
    var errors : Driver<String> {
        return errorOccuredSubject.asDriverOnErrorJustComplete()
    }
    
    var isLoading : Driver<Bool> {
        return isLoadingRelay.asDriver()
    }
    
    var monthText : Driver<String> {
        return oneMonthSubscriptionRelay.compactMap({ $0 })
            .map({ L10n.SubscriptionsScreen.monthPriceString($0.price.intValue) })
            .asDriverOnErrorJustComplete()
    }
    
    var yearText : Driver<String> {
        return oneYearSubscriptionRelay.compactMap({ $0 })
            .map({ L10n.SubscriptionsScreen.yearPriceString($0.price.intValue) })
            .asDriverOnErrorJustComplete()
    }
    
    var monthTrialText : Driver<String?> {
        return oneMonthSubscriptionRelay.map({
            $0?.introductoryPrice?.subscriptionPeriod.numberOfUnits
        })
            .map({
                $0 == nil ? nil : L10n.SubscriptionsScreen.daysFree(7)
            })
            .asDriverOnErrorJustComplete()
    }
    
    var yearTrialText : Driver<String?> {
        return oneYearSubscriptionRelay.map({ $0 })
            .map({
                $0 == nil ? nil : L10n.SubscriptionsScreen.daysFreeWithMonthPrice(14, $0!.price.intValue / 12)
            })
            .asDriverOnErrorJustComplete()
    }
}

