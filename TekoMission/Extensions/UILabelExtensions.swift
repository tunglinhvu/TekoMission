//
//  UILabelExtensions.swift
//  TekoMission
//
//  Created by linhvt on 6/29/19.
//  Copyright © 2019 ntq. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {

    func setStrikeThrough(text: String) {
        let strikeAttributeString: NSMutableAttributedString =  NSMutableAttributedString(string: text)
        strikeAttributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, strikeAttributeString.length))
        self.attributedText = strikeAttributeString
    }

}
