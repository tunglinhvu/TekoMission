//
//  File.swift
//  TekoMission
//
//  Created by linhvt on 6/29/19.
//  Copyright © 2019 ntq. All rights reserved.
//

import Foundation
import UIColor_Hex_Swift

class CustomNavigationController: UINavigationController {
    let NAV_TINT_COLOR = UIColor(TMColor.Tomato)
    let NAV_BAR_TINT_COLOR = UIColor.gray
    let NAV_TITLE_COLOR = UIColor(TMColor.DarkGrey)

    static let spacingDefaultNavigationBar = 20 // device plus: 20, otherwise: 16
    static let margin = 8

    override func viewDidLoad() {
        super.viewDidLoad()
        customAppearanceForNavigationBar(navigationBar: UINavigationBar.appearance(), barTintColor: NAV_BAR_TINT_COLOR, tintColor: NAV_TINT_COLOR, titleColor: NAV_TITLE_COLOR)
    }

    open func customAppearanceForNavigationBar(navigationBar: UINavigationBar, barTintColor: UIColor, tintColor: UIColor, titleColor: UIColor) {
        navigationBar.tintColor = tintColor
        navigationBar.barTintColor = barTintColor
        navigationBar.backgroundColor = barTintColor
        navigationBar.isTranslucent = false
        let navFont = UIFont.systemFont(ofSize: 17.0)
        navigationBar.titleTextAttributes = [NSAttributedStringKey.font: navFont, NSAttributedStringKey.foregroundColor: titleColor]
        navigationBar.shadowImage = UIImage()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)

    }

    func showBackButton() {
        let btnBack = UIButton(type: .custom)
        btnBack.setImage(UIImage(named: "ic_arrow_back")?.withRenderingMode(.alwaysOriginal), for: .normal)
        btnBack.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btnBack.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        let itemBack = UIBarButtonItem(customView: btnBack)
        topViewController?.navigationItem.setLeftBarButtonItems([itemBack], animated: true)
    }


    // MARK: - action
    @objc func backAction() {
        popViewController(animated: true)
    }


}
