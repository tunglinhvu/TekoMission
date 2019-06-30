//
//  ProSameKindCollectionViewCell.swift
//  TekoMission
//
//  Created by linhvt on 6/29/19.
//  Copyright © 2019 ntq. All rights reserved.
//

import UIKit

class ProSameKindCollectionViewCell: UICollectionViewCell {
    public static let height: CGFloat = 236
    public static let width: CGFloat = 150

    // MARK: - outlets
    @IBOutlet weak var imvProImage: UIImageView!
    @IBOutlet weak var lblProName: UILabel!
    @IBOutlet weak var lblProPrice: UILabel!
    @IBOutlet weak var lblProPriceBeforeSale: UILabel!
    @IBOutlet weak var lblProDiscountPercent: UILabel!
    @IBOutlet weak var viewPriceBeforeSale: UIStackView!


    // MARK: - variables

    // MARK: - life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
