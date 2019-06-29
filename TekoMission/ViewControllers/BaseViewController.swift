//
//  BaseViewController.swift
//  TekoMission
//
//  Created by linhvt on 6/28/19.
//  Copyright © 2019 ntq. All rights reserved.
//

import UIKit
import Toast_Swift

class BaseViewController: UIViewController {

    var lastStatus: ReachabilityStatus? = nil
    var isFirstTime: Bool = true

    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNeedsStatusBarAppearanceUpdate()
        initComponents()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        NotificationCenter.default.addObserver(self, selector: #selector(self.networkStatusChanged(_:)), name: NSNotification.Name(rawValue: ReachabilityStatusChangedNotification), object: nil)
        Reach().monitorReachabilityChanges()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: ReachabilityStatusChangedNotification), object: nil)
    }

    // MARK: - setup
    func setupNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    func initComponents() {

    }

    // MARK: - toast
    func showToast(message: String?) {
        DispatchQueue.main.async {
            self.view.makeToast(message)
        }
    }

    func hideAllToast() {
        self.view.hideAllToasts()
    }

    // MARK: - loading indicator
    func showLoadingIndicator() {
        if let window = AppDelegate.getCurrentAppDelegate().window {
            let hud = MBProgressHUD.showAdded(to: window, animated: true)
            hud.backgroundView.color = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.3)
            hud.backgroundView.style = .solidColor
        }
    }

    func hideLoadingIndicator() {
        if let window = AppDelegate.getCurrentAppDelegate().window {
            MBProgressHUD.hide(for: window, animated: true)
        }
    }

    // MARK: - network
    @objc func networkStatusChanged(_ notification: Notification) {
        let status = Reach().connectionStatus()
        if let mLastStatus = lastStatus, mLastStatus.description == status.description {
            return
        }
        switch status {
        case .unknown, .offline:
            self.showToast(message: NSLocalizedString("no_network", comment: ""))
        case .online(.wwan):
            if (!isFirstTime) {
                self.showToast(message: NSLocalizedString("fine_network", comment: ""))
                self.networkHasConnected()
            }
        case .online(.wiFi):
            if (!isFirstTime) {
                self.showToast(message: NSLocalizedString("fine_network", comment: ""))
                self.networkHasConnected()
            }
        }
        lastStatus = status
        isFirstTime = false

    }

    func networkHasConnected() {

    }
}
