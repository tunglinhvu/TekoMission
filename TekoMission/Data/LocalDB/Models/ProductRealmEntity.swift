//
//  ProductRealmEntity.swift
//  TekoMission
//
//  Created by linhvt on 6/28/19.
//  Copyright © 2019 ntq. All rights reserved.
//

import UIKit
import RealmSwift

class ProductRealmEntity: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var sku = ""
    @objc dynamic var name = ""
    @objc dynamic var price: Int = 0
    @objc dynamic var priceBeforeSale: Int = 0
    var images = List<String>()
    var attributeGroups = List<AttributeGroupRealmEntity>()

    override class func primaryKey() -> String? {
        return "sku"
    }
}
