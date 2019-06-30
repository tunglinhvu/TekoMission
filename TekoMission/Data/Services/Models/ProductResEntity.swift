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
    var attributeGroups: [AttributeGroupResEntity] = []

    override init() {
        super.init()
    }

    init(response: [String: JSON]) {
        if let data = response["sku"]?.stringValue {
            self.sku = data
        }
        if let data = response["name"]?.stringValue {
            self.name = data
        }
        if let data = response["price"]?.dictionaryValue {
            self.price = data["sellPrice"]?.intValue ?? 0
            self.priceBeforeSale = data["supplierSalePrice"]?.intValue ?? 0
        }
        let data = response["images"]?.arrayValue ?? []
        for jsonItem in data {
            let mData = jsonItem.dictionaryValue
            if let url = mData["url"]?.stringValue {
                self.images.append(url)
            }
        }

        let aData = response["attributeGroups"]?.arrayValue ?? []
        for jsonItem in aData {
            let mData = jsonItem.dictionaryValue
            self.attributeGroups.append(AttributeGroupResEntity.init(response: mData, sku: sku))
        }
    }
}
