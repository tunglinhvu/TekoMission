//
//  ExtraEntity.swift
//  TekoMission
//
//  Created by linhvt on 6/29/19.
//  Copyright © 2019 ntq. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class ExtraEntity: NSObject {
    var totalItems: Int = 0
    var page: Int = 0
    var pageSize: Int = 0

    init(response: [String: JSON]) {
        totalItems = response["totalItems"]?.intValue ?? 0
        page = response["page"]?.intValue ?? 0
        pageSize = response["pageSize"]?.intValue ?? 0
    }
}
