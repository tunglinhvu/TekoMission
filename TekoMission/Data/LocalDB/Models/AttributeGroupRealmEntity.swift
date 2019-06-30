//
//  AttributeGroupRealmEntity.swift
//  TekoMission
//
//  Created by linhvt on 6/30/19.
//  Copyright © 2019 ntq. All rights reserved.
//

import UIKit
import RealmSwift

class AttributeGroupRealmEntity: Object {
    @objc dynamic var identifier: String = ""
    @objc dynamic var name = ""
    @objc dynamic var value = ""

    override class func primaryKey() -> String? {
        return "identifier"
    }
}
