//
//  ReactionController.swift
//  pandy
//
//  Created by Gleb Shendrik on 20.08.2020.
//

import UIKit

class ReactionController: UIViewController {

    @IBOutlet weak var imageReaction1: DiaryItemImageView!
    @IBOutlet weak var imageReaction2: DiaryItemImageView!
    @IBOutlet weak var imageReaction3: DiaryItemImageView!
    @IBOutlet weak var imageReaction4: DiaryItemImageView!
    @IBOutlet weak var cntsContainerBottom: NSLayoutConstraint!
    @IBOutlet weak var cntsFilterContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var vContainer: UIView!
    @IBOutlet weak var dimView: UIView!
    
    enum ColorType {
        case green, red
    }
    
    typealias SummaryData = (type: EmotionType, summ: Int, colorType: ColorType, text: String)
    
    var cellsList: [SummaryData]  =
        [
            (type: .emoHeartface, summ: 200, colorType: .green, text: "Подарить"),
            (type: .emoAirkiss, summ: 50, colorType: .green, text: "Подарить"),
            (type: .emoFacewithsteam, summ: 5, colorType: .red, text: "Забрать"),
            (type: .emoSwearingface, summ: 200, colorType: .red, text: "Блокировать"),
    ]
    
    weak var delegate: DiaryDetailVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageReaction1.progress = 0
        imageReaction1.image.image = Images.emoHeartfaceIcon.image
        imageReaction1.backgroundColor = UIColor("C3F5D7")
        
        imageReaction2.progress = 0
        imageReaction2.image.image = Images.emoAirkissIcon.image
        imageReaction2.backgroundColor = UIColor("C3F5D7")
        
        imageReaction3.progress = 0
        imageReaction3.image.image = Images.emoFacewithsteamIcon.image
        imageReaction3.backgroundColor = UIColor("FFDBDE")
        
        imageReaction4.progress = 0
        imageReaction4.image.image = Images.emoSwearingfaceIcon.image
        imageReaction4.backgroundColor = UIColor("FFDBDE")
        
        setupViews()
    }
    
    func setupViews() {
        vContainer.clipsToBounds = true
        vContainer.layer.cornerRadius = 25.0
        vContainer.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        cntsContainerBottom.constant = -cntsFilterContainerHeight.constant
        let dimGr = UITapGestureRecognizer(target: self, action: #selector(dismissReaction))
        dimView.addGestureRecognizer(dimGr)
        let swipeGr = UISwipeGestureRecognizer(target: self, action: #selector(dismissReaction))
        swipeGr.direction = .down
        vContainer.addGestureRecognizer(swipeGr)
    }
    
    @objc func dismissReaction() {
        animateDissmissing {
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    func animateDissmissing(comlpletion : @escaping  () -> ()) {
        UIView.animate(withDuration: 0.2, animations: {
            self.dimView.backgroundColor = UIColor.black.withAlphaComponent(0)
            self.cntsContainerBottom.constant = -self.cntsFilterContainerHeight.constant
            self.view.layoutIfNeeded()
        }) { _ in
            comlpletion()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateApperarence()
    }
    
    func animateApperarence() {
        UIView.animate(withDuration: 0.2) {
            self.dimView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        }
        
        UIView.animate(withDuration: 0.2) {
            self.cntsContainerBottom.constant = 0
            self.view.layoutIfNeeded()
        }
    }

}

extension ReactionController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReactionCell", for: indexPath) as! ReactionCell
        let data = cellsList[indexPath.row]
        
        cell.textCell.text = data.text
        cell.summ.text = "\(data.summ)"
        if data.colorType == .green {
            cell.rubyImage.image = Images.greenRubyIcon.image
            cell.iconArrow.image = Images.upIcon.image
            cell.summ.textColor = UIColor("46C66F")
            cell.emojiImage.backgroundColor = UIColor("CDF3D9")
        } else {
            cell.rubyImage.image = Images.redRubyIcon.image
            cell.iconArrow.image = Images.downIcon.image
            cell.summ.textColor = UIColor("FF656E")
            cell.emojiImage.backgroundColor = UIColor("FFDDDF")
        }
        cell.emojiImage.image.image = data.type.icon
        cell.emojiImage.progress = 0
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let kWhateverHeightYouWant = 100
        return CGSize(width: view.bounds.width / 5.0, height: CGFloat(kWhateverHeightYouWant))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = cellsList[indexPath.row]
        delegate?.setReaction(withText: data.type.rawValue)
        dismissReaction()
    }
}
