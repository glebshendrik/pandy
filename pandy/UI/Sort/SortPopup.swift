//
//  SortPopup.swift
//  pandy
//
//  Created by Gleb Shendrik on 03.08.2020.
//

import Foundation
import SwiftMessages

class SortPopup: MessageView {
    
    var didSelectItemAtIndex : ((Int) -> ())?
    
    var items = [String]() {
        didSet {
            reloadItems()
        }
    }
    
    var selectedIndex : Int? {
        didSet {
            setSelection()
        }
    }
    
    @IBOutlet weak var svItemsContainer: UIStackView!
    @IBOutlet weak var lbTitle: UILabel!
    
    @IBOutlet weak var vClose: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    func setupViews() {
        layer.cornerRadius = 25
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.clipsToBounds = true
        vClose.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hide)))
    }
    
    func reloadItems() {
        svItemsContainer.arrangedSubviews.forEach({
            svItemsContainer.removeArrangedSubview($0)
            $0.removeFromSuperview()
        })
        for (index, item) in items.enumerated() {
            let iv = SortPopupItemView.loadFromNib()
            iv.translatesAutoresizingMaskIntoConstraints = false
            iv.heightAnchor.constraint(equalToConstant: 54).isActive = true
            iv.lbTitle.text = item
            iv.ivCheckIcon.image = index == selectedIndex ? Images.doneCommonIcon.image : nil
            iv.tag = index
            let gr = UITapGestureRecognizer(target: self, action: #selector(itemTapped(_:)))
            iv.addGestureRecognizer(gr)
            svItemsContainer.addArrangedSubview(iv)
        }
    }
    
    @objc func itemTapped(_ sender : UIGestureRecognizer) {
        guard let tag = sender.view?.tag else { return }
        selectedIndex = tag
        didSelectItemAtIndex?(tag)
        hide()
    }
    
    func setSelection() {
        for (index, view) in svItemsContainer.arrangedSubviews.enumerated() {
            guard let view = view as? SortPopupItemView else { return }
            view.ivCheckIcon.image = index == selectedIndex ? Images.doneCommonIcon.image : nil
        }
    }
    
    @objc func hide() {
        SwiftMessages.hide()
    }
}
