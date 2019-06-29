//
//  UICollectionViewExtension.swift
//  TekoMission
//
//  Created by linhvt on 6/29/19.
//  Copyright © 2019 ntq. All rights reserved.
//

import Foundation
extension UICollectionView {

    func registerCellNib<T: UICollectionViewCell>(_ aClass: T.Type) {
        let name = String(describing: aClass)
        if UIDevice.current.userInterfaceIdiom == .pad {
            let nibName = String.init(format: "%@_iPad", name)
            if Bundle.main.path(forResource: nibName, ofType: "nib") != nil {
                let nib = UINib(nibName: nibName, bundle: nil)
                self.register(nib, forCellWithReuseIdentifier: name)
                return
            }
        }
        let nib = UINib(nibName: name, bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: name)
    }
    func dequeueReusableCell<T: UICollectionViewCell>(_ aClass: T.Type,idxPath : IndexPath) -> T! {
        let name = String(describing: aClass)
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: name, for: idxPath) as? T else  {
            fatalError("\(name) is not registed")
        }
        return cell
    }

}
