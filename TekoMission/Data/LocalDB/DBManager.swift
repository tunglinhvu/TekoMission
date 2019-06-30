//
//  ProductsStore.swift
//  TekoMission
//
//  Created by linhvt on 6/29/19.
//  Copyright © 2019 ntq. All rights reserved.
//

import Foundation
import RealmSwift

typealias DBHandler = (_ isSuccess: Bool) -> Void

class DBManager {
    static let shared = DBManager()

    private init() {

    }

    func saveProducts(_ products: [ProductResEntity], query: String, completion: @escaping DBHandler) {
        let realm: Realm = try! Realm()
        do {
            try realm.write {
                for product in products {
                    // update products table
                    let prodRealmObj = ProductDTO.responseToRealm(resObj: product)
                    realm.add(prodRealmObj, update: true)

                    // update queries table
                    let predicate = NSPredicate(format: "query = %@ AND sku = %@", query, product.sku)
                    if let _ = realm.objects(QueryRealmEntity.self).filter(predicate).first {
                        // already added query
                        continue
                    }
                    let queryRealmObj = QueryRealmEntity()
                    queryRealmObj.query = query
                    queryRealmObj.sku = product.sku
                    realm.add(queryRealmObj)
                }
                completion(true)
            }
        } catch {
            completion(false)
        }
    }

    func getProductsByQuery(_ query: String) -> [ProductRealmEntity] {
        let realm: Realm = try! Realm()
        let queryPredicate = NSPredicate(format: "query = %@", query)
        let listSku: [QueryRealmEntity] = Array(realm.objects(QueryRealmEntity.self).filter(queryPredicate))
        let listSkuWithStringOnly = List<String>()
        for item in listSku {
            listSkuWithStringOnly.append(item.sku)
        }
        if listSkuWithStringOnly.count > 0 {
            let proPredicate = NSPredicate(format: "sku IN %@", listSkuWithStringOnly)
            let listProduct = realm.objects(ProductRealmEntity.self).filter(proPredicate)
            return Array(listProduct)
        }
        return []
    }

    func saveProduct(_ product: ProductResEntity, completion: @escaping DBHandler) {
        let realm: Realm = try! Realm()
        do {
            try realm.write {
                let prodRealmObj = ProductDTO.responseToRealm(resObj: product)
                realm.create(ProductRealmEntity.self, value: prodRealmObj, update: true)
            }
            completion(true)
        } catch {
            completion(false)
        }
    }

    func isHasProductInDBByQuery(_ query: String) -> Bool {
        let realm: Realm = try! Realm()
        let predicate = NSPredicate(format: "query = %@", query)
        if let _ = realm.objects(QueryRealmEntity.self).filter(predicate).first {
            return true
        }
        return false
    }

    func getProductBySku(_ sku: String) -> ProductRealmEntity? {
        let realm: Realm = try! Realm()
        let predicate = NSPredicate(format: "sku = %@", sku)
        let product = realm.objects(ProductRealmEntity.self).filter(predicate).first
        return product
    }
}
