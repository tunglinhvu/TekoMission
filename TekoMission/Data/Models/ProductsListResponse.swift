//
//  ProductsListResponse.swift
//  TekoMission
//
//  Created by linhvt on 6/29/19.
//  Copyright © 2019 ntq. All rights reserved.
//

import UIKit
import SwiftyJSON

class ProductsListResponse: BaseResponse {
    var extra: ExtraEntity?
    var products: [ProductEntityResponse] = []

    override init() {
        super.init()
    }

    override init(response: [String : JSON]) {
        super.init(response: response)
        if let data = response["extra"]?.dictionaryValue {
            extra = ExtraEntity.init(response: data)
        }
        let data = response["result"]?["products"].arrayValue ?? []
        for jsonItem in data {
            let entity = ProductEntityResponse.init(response: jsonItem.dictionaryValue)
            products.append(entity)
        }
    }
}
