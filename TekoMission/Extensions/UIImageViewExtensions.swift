//
//  UIImageViewExtensions.swift
//  TekoMission
//
//  Created by linhvt on 6/29/19.
//  Copyright © 2019 ntq. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

extension UIImageView {

    func setImageWithPlaceholder(linkImage: String) {
        self.sd_setImage(with: URL(string: linkImage), placeholderImage: UIImage(named: "ic_phongvu"), options: .cacheMemoryOnly, completed: nil)
    }

    func setImage(linkImage: String) {
        self.sd_setImage(with: URL(string: linkImage), completed: nil)
    }

}
