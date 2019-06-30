//
//  ProductsListViewController.swift
//  TekoMission
//
//  Created by linhvt on 6/28/19.
//  Copyright © 2019 ntq. All rights reserved.
//

import UIKit
import RealmSwift


class ProductsListViewController: BaseViewController {

    @IBOutlet weak var tfSearch: UITextField!
    @IBOutlet weak var tableProducts: UITableView!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var btnLayoutDismiss: UIButton!

    //MARK: - Properties
    lazy var listProducts: [ProductRealmEntity] = []
    var realm: Realm = try! Realm()

    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    // MARK: - setup
    override func initComponents() {
        super.initComponents()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        self.setupTableView()
        self.setupTextField()

        if DBManager.shared.isHasProductInDBByQuery("") {
            self.initDataFromRealmDBWithQuery("")
        } else {
            self.initFirstData()
        }
    }

    func initFirstData() {
        self.requestProductsWithQuery("", withLoadingIndicator: true)
    }

    func requestProductsWithQuery(_ query: String, withLoadingIndicator loadingIndicator: Bool) {
        if loadingIndicator {
            self.showLoadingIndicator()
        }
        let sv = ProductsService()
        sv.requestListProducts(query: query) { (ProductsListResEntity, responseResult) in
            self.hideLoadingIndicator()
            guard responseResult.code == .success, let productsListRes = ProductsListResEntity else {
                self.showToast(message: responseResult.description)
                return
            }

            DBManager.shared.saveProducts(productsListRes.products, query: query)
            self.initDataFromRealmDBWithQuery(query)
        }
    }

    func initDataFromRealmDBWithQuery(_ query: String) {
        self.listProducts = Array(DBManager.shared.getProductsByQuery(query))
        self.tableProducts.reloadData()
    }

    override func setupNavigationBar() {
        super.setupNavigationBar()
    }

    // MARK: - action
    @IBAction func backAction(_ sender: UIButton) {
        // just do nothing
    }

    @IBAction func dismissSearchAction(_ sender: Any) {
        self.tfSearch.resignFirstResponder()
        self.performAction()
    }
}

// MARK: - textfield delegate
extension ProductsListViewController: UITextFieldDelegate {
    fileprivate func setupTextField() {
        self.tfSearch.delegate = self
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        btnLayoutDismiss.isHidden = false
        return true
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        btnLayoutDismiss.isHidden = true
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        performAction()
        return true
    }

    func performAction() {
        //action events
        let query = tfSearch.text ?? ""
        if DBManager.shared.isHasProductInDBByQuery(query) {
            self.initDataFromRealmDBWithQuery(query)
        } else {
            self.requestProductsWithQuery(query, withLoadingIndicator: true)
        }
    }
}

// MARK: - tableView delegate & datasource
extension ProductsListViewController: UITableViewDelegate, UITableViewDataSource {
    fileprivate func setupTableView() {
        self.tableProducts.separatorStyle = .none
        self.tableProducts.registerCellNib(ProductsListTableViewCell.self)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listProducts.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ProductsListTableViewCell.height
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ProductsListTableViewCell = tableView.dequeueReusableCell(ProductsListTableViewCell.self, idxPath: indexPath)
        cell.fillData(listProducts[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = self.listProducts[indexPath.row]
        let vc = ProductDetailViewController.instantiateFromNib()
        vc.product = product
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
