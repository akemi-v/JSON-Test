//
//  UITextViewFixed.swift
//  JSON Test
//
//  Created by Maria Semakova on 10/24/17.
//  Copyright © 2017 Maria Semakova. All rights reserved.
//

import Foundation

import UIKit

@IBDesignable class UITextViewFixed: UITextView {
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    func setup() {
        textContainerInset = UIEdgeInsets.zero
        textContainer.lineFragmentPadding = 0
    }
}

func updateTextViewFrame(textView: UITextView?) -> CGRect? {
    guard let fixedWidth = textView?.frame.size.width else { return nil }
    textView?.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
    guard let newSize = textView?.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude)) else { return nil }
    guard var newFrame = textView?.frame else { return nil }
    newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
    
    return newFrame
}

func dictToString(dict: [String: Any]) -> String {
    return (dict.flatMap({ (key, value) -> String in
        return "\(key): \(value)"
    }) as Array).joined(separator: "\n")
}

func dictToStringJSON(dict: [String: Any]) -> String {
    let body = (dict.flatMap({ (key, value) -> String in
        return "\t\"\(key)\": \"\(value)\""
    }) as Array).joined(separator: ",\n")
    return "{\n\(body)\n}"
}
