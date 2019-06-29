//
//  ProductsStore.swift
//  TekoMission
//
//  Created by linhvt on 6/29/19.
//  Copyright © 2019 ntq. All rights reserved.
//

import Foundation
import RealmSwift

class DBManager {
    static let shared = DBManager()

    private init() {

    }

    func saveProducts(_ products: [ProductEntityResponse], query: String) {
        let realm: Realm = try! Realm()
        for product in products {
            let realmObj = product.convertToRealmObject()
            let predicate = NSPredicate(format: "query = %@ AND sku = %@", query, product.sku)
            if let _ = realm.objects(ProductRealmEntity.self).filter(predicate).first {
                // already added
                return
            }
            realmObj.query = query
            try! realm.write {
                realm.add(realmObj)
            }
        }
    }

    func getProductsByQuery(_ query: String) -> Results<ProductRealmEntity> {
        let realm: Realm = try! Realm()
        let predicate = NSPredicate(format: "query = %@", query)
        return realm.objects(ProductRealmEntity.self).filter(predicate)
    }

    func isHasProductInDBByQuery(_ query: String) -> Bool {
        let realm: Realm = try! Realm()
        let predicate = NSPredicate(format: "query = %@", query)
        if let _ = realm.objects(ProductRealmEntity.self).filter(predicate).first {
            return true
        }
        return false
    }
}
