//
//  ProductResEntity.swift
//  TekoMission
//
//  Created by linhvt on 6/29/19.
//  Copyright © 2019 ntq. All rights reserved.
//

import UIKit
import SwiftyJSON

class ProductResEntity: NSObject {
    var sku = ""
    var name = ""
    var price: Int = 0
    var priceBeforeSale: Int = 0
    var images: [String] = []

    override init() {
        super.init()
    }

    init(response: [String: JSON]) {
        if let data = response["sku"]?.stringValue {
            sku = data
        }
        if let data = response["name"]?.stringValue {
            name = data
        }
        if let data = response["price"]?.dictionaryValue {
            price = data["sellPrice"]?.intValue ?? 0
            priceBeforeSale = data["supplierSalePrice"]?.intValue ?? 0
        }
        let data = response["images"]?.arrayValue ?? []
        for jsonItem in data {
            let mData = jsonItem.dictionaryValue
            if let url = mData["url"]?.stringValue {
                images.append(url)
            }
        }
    }
}
