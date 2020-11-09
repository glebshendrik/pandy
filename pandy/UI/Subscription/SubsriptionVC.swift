//
//  SubsriptionVC.swift
//  pandy
//
//  Created by Gleb Shendrik on 08.09.2020.
//

import UIKit
import SimpleButton
import RxSwift
import RxCocoa
import RxGesture

class SubsriptionVC : BaseViewController {
    
    let disposeBag = DisposeBag()
    
    var viewModel: Attachable<SubscriptionVM>!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var vYearSubscription: UIView!
    @IBOutlet weak var lbYearSubscriptionPrice: UILabel!
    @IBOutlet weak var lbYearSubscriptionInfo: UILabel!
    @IBOutlet weak var ivYearSubscriptionCheckbox: UIImageView!
    
    @IBOutlet weak var vMonthSubscription: UIView!
    @IBOutlet weak var lbMonthSubscriptionPrice: UILabel!
    @IBOutlet weak var lbMonthSubscriptionDetails: UILabel!
    @IBOutlet weak var ivMonthSubscriptionCheckbox: UIImageView!
    
    @IBOutlet weak var btnStarFree: UIButton!
    @IBOutlet weak var btnTermsAndConditions: UIButton!
    @IBOutlet weak var btnContract: UIButton!
    
    @IBOutlet weak var svInfoItems: UIStackView!
    @IBOutlet weak var lbTitle: UILabel!
    
    @IBOutlet weak var vRetry: UIView!
    @IBOutlet weak var lbRetryTitle: UILabel!
    @IBOutlet weak var btnRetry: SimpleButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentToShowView = scrollView
        errorView = vRetry
        setupViews()
    }
    
    func setupViews() {
        
        scrollView.delaysContentTouches = false
        
        vYearSubscription.layer.cornerRadius = 20
        vYearSubscription.layer.masksToBounds = true
        vYearSubscription.layer.borderWidth = 1
        vYearSubscription.layer.borderColor = UIColor.color(from: "E9F0F3").cgColor
        
        btnRetry.layer.cornerRadius = 14
        btnRetry.layer.masksToBounds = true
        
        vMonthSubscription.layer.cornerRadius = 20
        vMonthSubscription.layer.masksToBounds = true
        vMonthSubscription.layer.borderWidth = 1
        vMonthSubscription.layer.borderColor = UIColor.color(from: "E9F0F3").cgColor
        
        ivYearSubscriptionCheckbox.tintColor = UIColor.white
        ivYearSubscriptionCheckbox.image = Images.checkboxFilled.image.withRenderingMode(.alwaysTemplate)
        
        btnStarFree.layer.cornerRadius = 14
        btnStarFree.layer.masksToBounds = true
        
        let yearGr = UITapGestureRecognizer(target: self, action: #selector(yearPressed))
        vYearSubscription.addGestureRecognizer(yearGr)
        
        let monthGr = UITapGestureRecognizer(target: self, action: #selector(monthPressed))
        vMonthSubscription.addGestureRecognizer(monthGr)
    }
    
    @objc func yearPressed() {
        vYearSubscription.backgroundColor = UIColor.color(from: "#58D380")
        vYearSubscription.layer.borderColor = UIColor.clear.cgColor
        ivYearSubscriptionCheckbox.image = Images.checkboxFilled.image.withRenderingMode(.alwaysTemplate)
        ivYearSubscriptionCheckbox.tintColor = UIColor.white
        
        lbMonthSubscriptionPrice.textColor = UIColor.color(from: "#3F4860")
        lbMonthSubscriptionDetails.textColor = UIColor.color(from: "#3F4860")
        
        vMonthSubscription.backgroundColor = UIColor.white
        vMonthSubscription.layer.borderWidth = 1
        vMonthSubscription.layer.borderColor = UIColor.color(from: "E9F0F3").cgColor
        ivMonthSubscriptionCheckbox.image = Images.checkboxEmpty.image.withRenderingMode(.alwaysOriginal)
        
        lbYearSubscriptionPrice.textColor = UIColor.white
        lbYearSubscriptionInfo.textColor = UIColor.white
    }
    
    @objc func monthPressed() {
        vMonthSubscription.backgroundColor = UIColor.color(from: "#58D380")
        vMonthSubscription.layer.borderColor = UIColor.clear.cgColor
        ivMonthSubscriptionCheckbox.image = Images.checkboxFilled.image.withRenderingMode(.alwaysTemplate)
        ivMonthSubscriptionCheckbox.tintColor = UIColor.white
        
        lbYearSubscriptionPrice.textColor = UIColor.color(from: "#3F4860")
        lbYearSubscriptionInfo.textColor = UIColor.color(from: "#3F4860")
        
        vYearSubscription.backgroundColor = UIColor.white
        vYearSubscription.layer.borderWidth = 1
        vYearSubscription.layer.borderColor = UIColor.color(from: "E9F0F3").cgColor
        ivYearSubscriptionCheckbox.image = Images.checkboxEmpty.image.withRenderingMode(.alwaysOriginal)
        
        lbMonthSubscriptionPrice.textColor = UIColor.white
        lbMonthSubscriptionDetails.textColor = UIColor.white
    }
}

extension SubsriptionVC : ViewModelAttaching {
    
    var bindings: SubscriptionVM.Bindings {
        let didPressContinueForFree = btnStarFree.rx.tap.asDriver()
        return SubscriptionVM.Bindings(didPressContinueForFree: didPressContinueForFree)
    }
    
    func bind(viewModel: SubscriptionVM) -> SubscriptionVM {
        
        viewModel.monthText.drive(lbMonthSubscriptionPrice.rx.text).disposed(by: disposeBag)
        viewModel.monthTrialText.drive(lbMonthSubscriptionDetails.rx.text).disposed(by: disposeBag)
        viewModel.yearText.drive(lbYearSubscriptionPrice.rx.text).disposed(by: disposeBag)
        viewModel.yearTrialText.drive(lbYearSubscriptionInfo.rx.text).disposed(by: disposeBag)
        
        viewModel.isLoading.debug("PENIS").drive(onNext : { [weak self] loading in
            if loading {
                self?.showActivityHUD()
            } else {
                self?.hideActivityHUD()
            }
        }).disposed(by: disposeBag)
        viewModel.errors.drive(onNext : { [weak self] error in
            self?.showErrorToast(with: error)
        }).disposed(by: disposeBag)
        viewModel.state.drive(self.rx.controllerState).disposed(by: disposeBag)
        return viewModel
    }
}
