//
//  ProductsService.swift
//  TekoMission
//
//  Created by linhvt on 6/29/19.
//  Copyright © 2019 ntq. All rights reserved.
//

import Foundation
import SwiftyJSON

typealias GetListRankingHandler = (_ listProducts: ProductsListResEntity?, _ result: TMResponseResult) -> Void

class ProductsService: BaseService {
    func requestListProducts(query: String, completion: @escaping GetListRankingHandler) {
        let parameters = [
            "channel": "pv_online",
            "visitorId": "",
            "q": query,
            "terminal": "cp01"
        ]
        self.get(service: Services.GET_PRODUCTS_LIST, parameters: parameters, hasToken:false) { (data, responseType) in
            if responseType == .success {
                let json = JSON.init(data)
//                let data = json["data"].dictionaryValue
                let productsListRes = ProductsListResEntity.init(response: json.dictionaryValue)
                let resRequest = TMResponseResult(code: .success, description: "success")
                completion(productsListRes, resRequest)
            } else {
                let resRequest = TMResponseResult(code: .nemo, description: responseType.description)
                completion(nil, resRequest)
            }
        }
    }


}
