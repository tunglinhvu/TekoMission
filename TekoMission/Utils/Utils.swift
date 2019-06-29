//
//  Utils.swift
//  TekoMission
//
//  Created by linhvt on 6/29/19.
//  Copyright © 2019 ntq. All rights reserved.
//

import Foundation

class Utils {
    public static func convertPriceToText(price: Int) -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.locale = Locale(identifier: "vi")
        let priceText = numberFormatter.string(from: NSNumber(value:price))
        return priceText
    }

    public static func getPercentOf(price: Int, presalePrice: Int) -> String? {
        let percent = 1 - (Double(price) / Double(presalePrice))
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.percent
        let discountPercent = numberFormatter.string(from: NSNumber(value: percent))
        return discountPercent
    }
}
