//
//  String+Extensions.swift
//  eljur
//
//  Created by Gleb Shendrik on 12/11/2019.
//
//

import Foundation
import UIKit

extension String {
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
    
    func NSRange(of substring: String) -> NSRange? {
        // Get the swift range
        guard let range = range(of: substring) else { return nil }
        
        // Get the distance to the start of the substring
        let start = distance(from: startIndex, to: range.lowerBound) as Int
        //Get the distance to the end of the substring
        let end = distance(from: startIndex, to: range.upperBound) as Int
        
        //length = endOfSubstring - startOfSubstring
        //start = startOfSubstring
        return NSMakeRange(start, end - start)
    }
}
extension String {
//    func strikeThrough() -> NSAttributedString {
//        let attributeString = NSMutableAttributedString(string: self)
//        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSRange(location: 0, length: attributeString.length))
//        return attributeString
//   }
 }
extension String {
    var digits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
    }
    
    var doubleDigits : String {
        return components(separatedBy: CharacterSet(charactersIn: "1234567890.").inverted).joined(separator: "")
    }
    
    var double : Double {
        return Double(self) ?? 0.0
    }
    
    var doubleValue : Double? {
        return Double(self)
    }
}

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.width)
    }
}

extension String {
    enum AdditionWordType {
        case comment, works
    }
    
    func getCountAddition(num: Int, type: AdditionWordType = .works) -> String {
        
        var setWords: (String, String, String)
        
        switch type {
        case .works:
            setWords = ("раз", "раза", "")
        case .comment:
            setWords = ("комментарий", "комментария", "комментариев")
        }
        let preLastDigit = num % 100 / 10;
        
        if (preLastDigit == 1) {
            return setWords.0;
        }
        
        switch (num % 10) {
        case 1:
            return setWords.0
        case 2,3,4:
            return setWords.1
        default:
            if type == .comment {return setWords.2}
            return setWords.0;
        }
    }
}
