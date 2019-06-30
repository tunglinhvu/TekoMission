//
//  AttributeGroupResEntity.swift
//  TekoMission
//
//  Created by linhvt on 6/30/19.
//  Copyright © 2019 ntq. All rights reserved.
//

import UIKit
import SwiftyJSON

class AttributeGroupResEntity: NSObject {
    var name = ""
    var value = ""
    var sku = ""

    init(response: [String: JSON], sku: String) {
        self.name = response["name"]?.stringValue ?? ""
        self.value = response["value"]?.stringValue ?? ""
        self.sku = sku
    }
}
