//
//  APIDefine.swift
//  TekoMission
//
//  Created by linhvt on 6/29/19.
//  Copyright © 2019 ntq. All rights reserved.
//

import Foundation

struct APIDefine {
    static let BaseUrlAPI = Bundle.main.object(forInfoDictionaryKey: "ROOT_URL_API") as! String
}

struct Services {
    static let GET_PRODUCTS_LIST = "search/"
    static let GET_PRODUCT_DETAIL = "products/"
}
