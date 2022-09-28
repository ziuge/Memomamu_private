//
//  AttributedString+Extension.swift
//  Memomamu
//
//  Created by CHOI on 2022/09/29.
//

import UIKit

extension UITextView {
    func setLineAndLetterSpacing(_ text: String){
        let style = NSMutableParagraphStyle()
        // 행간 세팅
        style.lineSpacing = 4
        let attributedString = NSMutableAttributedString(string: text)
        // 자간 세팅
//        attributedString.addAttribute(NSAttributedString.Key.kern, value: CGFloat(0), range: NSRange(location: 0, length: attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSRange(location: 0, length: attributedString.length))
        self.attributedText = attributedString
    }
}
