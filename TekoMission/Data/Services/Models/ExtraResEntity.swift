//
//  ExtraResEntity.swift
//  TekoMission
//
//  Created by linhvt on 6/29/19.
//  Copyright © 2019 ntq. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class ExtraResEntity: NSObject {
    var totalItems: Int = 0
    var page: Int = 0
    var pageSize: Int = 0

    init(response: [String: JSON]) {
        self.totalItems = response["totalItems"]?.intValue ?? 0
        self.page = response["page"]?.intValue ?? 0
        self.pageSize = response["pageSize"]?.intValue ?? 0
    }
}
