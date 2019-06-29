//
//  UIViewControllerExtensions.swift
//  TekoMission
//
//  Created by linhvt on 6/29/19.
//  Copyright © 2019 ntq. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
        navigationController?.navigationBar.endEditing(true)
    }

    static func instantiateFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>(_ viewType: T.Type) -> T {
            if UIDevice.current.userInterfaceIdiom == .pad {
                let nibName = String.init(format: "%@_iPad", String(describing: T.self))
                if Bundle.main.path(forResource: nibName, ofType: "nib") != nil {
                    return T.init(nibName: nibName, bundle: nil)
                }
            }
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }
        return instantiateFromNib(self)
    }
}
