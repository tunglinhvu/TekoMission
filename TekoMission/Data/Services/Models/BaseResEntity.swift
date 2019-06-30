//
//  BaseResEntity.swift
//  TekoMission
//
//  Created by linhvt on 6/29/19.
//  Copyright © 2019 ntq. All rights reserved.
//

import UIKit
import SwiftyJSON

class BaseResEntity: NSObject {
    var code: String = ""

    override init() {
        self.code = ""
        super.init()
    }

    init(response: [String: JSON]) {
        self.code = response["code"]?.stringValue ?? ""
    }

}
