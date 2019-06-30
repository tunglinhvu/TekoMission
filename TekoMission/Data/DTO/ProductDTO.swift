//
//  ProductDTO.swift
//  TekoMission
//
//  Created by linhvt on 6/30/19.
//  Copyright © 2019 ntq. All rights reserved.
//

import Foundation
import RealmSwift

class ProductDTO {
    public static func responseToRealm(resObj: ProductResEntity) -> ProductRealmEntity {
        let realmObject = ProductRealmEntity()
        realmObject.sku = resObj.sku
        realmObject.name = resObj.name
        realmObject.price = resObj.price
        realmObject.priceBeforeSale = resObj.priceBeforeSale
        realmObject.images = List<String>()
        realmObject.images.append(objectsIn: resObj.images)
        return realmObject
    }
}
