//
//  StartScreenVC.swift
//  pandy
//
//  Created by Gleb Shendrik on 07.09.2020.
//

import UIKit
import RxSwift
import RxCocoa

class StartScreenVC : BaseViewController, ViewModelAttaching {
    
    var bindings: StartScreenVM.Bindings {
        let didPressReadyToStart = btnReady.rx.tap.asDriver()
        let didPressSignIn = btnHaveAccount.rx.tap.asDriver()
        return StartScreenVM.Bindings(didPressReadyToStart: didPressReadyToStart,
                                      didPressSignIn: didPressSignIn)
    }
    
    func bind(viewModel: StartScreenVM) -> StartScreenVM {
        viewModel.isLoading.drive(onNext : { [weak self] loading in
            if loading {
                self?.showActivityHUD()
            } else {
                self?.hideActivityHUD()
            }
        }).disposed(by: disposeBag)
        viewModel.errors.drive(onNext : { [weak self] error in
            self?.showErrorToast(with: error)
        }).disposed(by: disposeBag)
        return viewModel
    }
    
    let disposeBag = DisposeBag()
    
    var viewModel: Attachable<StartScreenVM>!
    
    @IBOutlet weak var btnHaveAccount: UIButton!
    @IBOutlet weak var btnReady: UIButton!
    @IBOutlet weak var lbSubtitle: UILabel!
    @IBOutlet weak var lbHello: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupControls()
    }
    
    func setupControls() {
        lbHello.text = L10n.StartScreen.title
        lbSubtitle.text = L10n.StartScreen.subtitle
        btnHaveAccount.setTitle(L10n.StartScreen.haveAccountButtonText, for: .normal)
        btnReady.layer.cornerRadius = 14
        btnReady.layer.masksToBounds = true
        btnReady.setTitle(L10n.StartScreen.readyButtonText, for: .normal)
    }
}
