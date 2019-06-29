//
//  UITableViewExtensions.swift
//  TekoMission
//
//  Created by linhvt on 6/29/19.
//  Copyright © 2019 ntq. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func registerCellNib<T: UITableViewCell>(_ aClass: T.Type) {
        let name = String(describing: aClass)
        if UIDevice.current.userInterfaceIdiom == .pad {
            let nibName = String.init(format: "%@_iPad", name)
            if Bundle.main.path(forResource: nibName, ofType: "nib") != nil {
                let nib = UINib(nibName: nibName, bundle: nil)
                self.register(nib, forCellReuseIdentifier: name)
                return
            }
        }
        let nib = UINib(nibName: name, bundle: nil)
        self.register(nib, forCellReuseIdentifier: name)
    }

    func dequeueReusableCell<T: UITableViewCell>(_ aClass: T.Type, idxPath : IndexPath) -> T! {
        let name = String(describing: aClass)
        guard let cell = dequeueReusableCell(withIdentifier: name, for: idxPath) as? T else {
            fatalError("\(name) is not registed")
        }
        return cell
    }

    func registerHeaderCellNib<T: UITableViewHeaderFooterView>(_ aClass: T.Type) {
        let name = String(describing: aClass)
        if UIDevice.current.userInterfaceIdiom == .pad {
            let nibName = String.init(format: "%@_iPad", name)
            if Bundle.main.path(forResource: nibName, ofType: "nib") != nil {
                let nib = UINib(nibName: nibName, bundle: nil)
                self.register(nib, forHeaderFooterViewReuseIdentifier: name)
                return
            }
        }
        let nib = UINib(nibName: name, bundle: nil)
        self.register(nib, forHeaderFooterViewReuseIdentifier: name)
    }

    func dequeueReusableHeaderCell<T: UITableViewHeaderFooterView>(_ aClass: T.Type) -> T! {
        let name = String(describing: aClass)
        guard let cell = dequeueReusableHeaderFooterView(withIdentifier: name) as? T else {
            fatalError("\(name) is not registed")
        }
        return cell
    }
}
