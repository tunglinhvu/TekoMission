//
//  BaseResponse.swift
//  TekoMission
//
//  Created by linhvt on 6/29/19.
//  Copyright © 2019 ntq. All rights reserved.
//

import UIKit
import SwiftyJSON

class BaseResponse: NSObject {
    var code: String = ""

    override init() {
        code = ""
        super.init()
    }

    init(response: [String: JSON]) {
        code = response["code"]?.stringValue ?? ""
    }

}
