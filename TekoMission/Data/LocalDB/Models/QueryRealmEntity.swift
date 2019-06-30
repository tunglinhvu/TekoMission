//
//  QueryRealm.swift
//  TekoMission
//
//  Created by linhvt on 6/29/19.
//  Copyright © 2019 ntq. All rights reserved.
//

import UIKit
import RealmSwift

class QueryRealmEntity: Object {
    @objc dynamic var identifier: String = UUID().uuidString
    @objc dynamic var sku = ""
    @objc dynamic var query = ""

    override class func primaryKey() -> String? {
        return "identifier"
    }
}
