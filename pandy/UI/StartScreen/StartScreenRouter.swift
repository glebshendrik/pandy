//
//  StartScreenRouter.swift
//  pandy
//
//  Created by Gleb Shendrik on 13.09.2020.
//

import Foundation
import RxSwift

class StartScreenRouter : BaseRouter {
    func openSignInScreen(didLoginObserver : PublishSubject<Profile>?) {
        let vc = SignInVC.instanceFromStoryboard()
        let deps = SignInVM.Dependency(userService: UserService(apiClient: APIClient()))
        let navm : Attachable<SignInVM> = .detached(deps)
        let vm = vc.attach(wrapper: navm)
        vm.didAuthorize.drive(onNext : {[weak didLoginObserver] profile in
            didLoginObserver?.onNext(profile)
        }).disposed(by: disposeBag)
        vc.definesPresentationContext = true
        vc.modalPresentationStyle = .overFullScreen
        sourceViewController?.present(vc, animated: false, completion: nil)
    }
}
