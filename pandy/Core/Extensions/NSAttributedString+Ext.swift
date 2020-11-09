//
//  NSAttributedString+Ext.swift
//  eljur
//
//  Created by Gleb Shendrik on 02/10/2019.
//
//

import Foundation
import UIKit

extension NSAttributedString {
    static func string(_ string : String, with attributes: [NSAttributedString.Key : Any], image : UIImage? = nil, offsetY : CGFloat? = nil) -> NSAttributedString {
        let stringToDisplay = image == nil ? string : string + "  "
        let attrStr = NSMutableAttributedString(string: stringToDisplay, attributes: attributes)
        if let image = image {
            let attachment = NSTextAttachment()
            attachment.image = image
            if let offsetY = offsetY {
                let newBounds = CGRect(x: 0, y: offsetY, width: image.size.width, height: image.size.height)
                attachment.bounds = newBounds
            }
            let iconString = NSAttributedString(attachment: attachment)
            attrStr.append(iconString)
        }
        return attrStr
    }
    
    convenience init?(html: String) {
        guard let data = html.data(using: String.Encoding.utf16, allowLossyConversion: false) else {
            return nil
        }
        guard let attributedString = try? NSMutableAttributedString(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) else {
            return nil
        }
        self.init(attributedString: attributedString)
    }
}
extension NSAttributedString {

    convenience init(htmlString html: String, font: UIFont? = nil, useDocumentFontSize: Bool = true, keepSymbolicTraits : Bool = false, fontColor : UIColor? = nil) throws {
        let options: [NSAttributedString.DocumentReadingOptionKey : Any] = [
            NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html,
            NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue
        ]

        let data = html.data(using: .utf8, allowLossyConversion: true)
        guard (data != nil), let fontFamily = font?.familyName, let attr = try? NSMutableAttributedString(data: data!, options: options, documentAttributes: nil) else {
            try self.init(data: data ?? Data(html.utf8), options: options, documentAttributes: nil)
            return
        }

        let fontSize: CGFloat? = useDocumentFontSize ? nil : font!.pointSize
        let range = NSRange(location: 0, length: attr.length)
        attr.enumerateAttribute(NSAttributedString.Key.font, in: range, options: .longestEffectiveRangeNotRequired) { attrib, range, _ in
            if let htmlFont = attrib as? UIFont {
                let traits = htmlFont.fontDescriptor.symbolicTraits
                var descrip = htmlFont.fontDescriptor.withFamily(fontFamily)

                if keepSymbolicTraits {
                    if (traits.rawValue & UIFontDescriptor.SymbolicTraits.traitBold.rawValue) != 0 {
                        descrip = descrip.withSymbolicTraits(.traitBold)!
                    }

                    if (traits.rawValue & UIFontDescriptor.SymbolicTraits.traitItalic.rawValue) != 0 {
                        descrip = descrip.withSymbolicTraits(.traitItalic)!
                    }
                }
                

                attr.addAttribute(NSAttributedString.Key.font, value: UIFont(descriptor: descrip, size: fontSize ?? htmlFont.pointSize), range: range)
                if let fc = fontColor {
                    attr.addAttribute(NSAttributedString.Key.foregroundColor, value: fc, range: range)
                }
                
            }
        }

        self.init(attributedString: attr)
    }

}
extension NSAttributedString {
//    func attributedStringWithResizedImages(with maxWidth: CGFloat) -> NSAttributedString {
//        let text = NSMutableAttributedString(attributedString: self)
//        text.enumerateAttribute(NSAttributedString.Key.attachment, in: NSMakeRange(0, text.length), options: .init(rawValue: 0), using: { (value, range, stop) in
//            if let attachement = value as? NSTextAttachment {
//                let image = attachement.image(forBounds: attachement.bounds, textContainer: NSTextContainer(), characterIndex: range.location)!
//                if image.size.width > maxWidth {
//                    let newImage = image.resizeImage(scale: maxWidth/image.size.width)
//                    let newAttribut = NSTextAttachment()
//                    newAttribut.image = newImage
//                    text.addAttribute(NSAttributedString.Key.attachment, value: newAttribut, range: range)
//                }
//            }
//        })
//        return text
//    }
}
