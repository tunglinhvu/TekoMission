//
//  AttributeGroupResEntity.swift
//  TekoMission
//
//  Created by linhvt on 6/30/19.
//  Copyright © 2019 ntq. All rights reserved.
//

import Foundation

class AttributeGroupDTO {
    public static func responseToRealm(resObj: AttributeGroupResEntity) -> AttributeGroupRealmEntity {
        let realmObject = AttributeGroupRealmEntity()
        realmObject.value = resObj.value
        realmObject.name = resObj.name
        realmObject.identifier = "\(resObj.sku)+++\(resObj.name)" // cause id = null so create id by my self.
        return realmObject
    }
}
