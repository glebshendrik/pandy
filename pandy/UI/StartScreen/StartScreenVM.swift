//
//  StartScreenVM.swift
//  pandy
//
//  Created by Gleb Shendrik on 13.09.2020.
//

import RxSwift
import RxCocoa

class StartScreenVM: ViewModelType {
    
    let disposeBag = DisposeBag()
    
    private let isLoadingRelay = BehaviorRelay<Bool>(value: false)
    private let errorOccuredSubject = PublishSubject<String>()
    private let didCreateNewUserSubject = PublishSubject<Void>()
    private let didAuthorizeSubject = PublishSubject<Profile>()
    
    required init(dependency: StartScreenVM.Dependency, bindings: StartScreenVM.Bindings) {
        
        bindings.didPressSignIn.drive(onNext : {[weak self] in
            dependency.router.openSignInScreen(didLoginObserver: self?.didAuthorizeSubject)
        }).disposed(by: disposeBag)
        
        let userRequestEvent = bindings.didPressReadyToStart.asObservable()
        userRequestEvent.mapTo(true).bind(to: isLoadingRelay).disposed(by: disposeBag)
        let userRequest = userRequestEvent.flatMapLatest({
            return dependency.userService
                .createUser(deviceName: UIDevice.modelName)
                .asObservable()
                .do(onNext : { token in
                    CredentialsStorage.shared.authorizationToken = token.token
                    CredentialsStorage.shared.userId = token.userID
                })
                .materialize()
        })
        .share()
        userRequest.elements().mapTo(false).bind(to: isLoadingRelay).disposed(by: disposeBag)
        userRequest.elements().mapToVoid().bind(to: didCreateNewUserSubject).disposed(by: disposeBag)
        userRequest.errors()
            .map({$0.localizedDescription})
            .bind(to: errorOccuredSubject)
            .disposed(by: disposeBag)
    }
    
    struct Dependency {
        let userService : UserServiceType
        let router : StartScreenRouter
    }
    
    struct Bindings {
        let didPressReadyToStart : Driver<Void>
        let didPressSignIn : Driver<Void>
    }
}

// Router output
extension StartScreenVM {
    var didCreateNewUser : Driver<Void> {
        return didCreateNewUserSubject.asDriverOnErrorJustComplete()
    }
    
    var didAuthorize : Driver<Profile> {
        return didAuthorizeSubject.asDriverOnErrorJustComplete()
    }
}

// Controller output
extension StartScreenVM {
    var errors : Driver<String> {
        return errorOccuredSubject.asDriverOnErrorJustComplete()
    }
    
    var isLoading : Driver<Bool> {
        return isLoadingRelay.asDriver()
    }
}
