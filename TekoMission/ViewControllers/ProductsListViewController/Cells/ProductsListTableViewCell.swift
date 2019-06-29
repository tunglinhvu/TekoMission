//
//  ProductsListTableViewCell.swift
//  TekoMission
//
//  Created by linhvt on 6/28/19.
//  Copyright © 2019 ntq. All rights reserved.
//

import UIKit


class ProductsListTableViewCell: UITableViewCell {

    public static let height: CGFloat = 104

    // MARK: - Outlets & variables
    @IBOutlet var imvProductImage: UIImageView!
    @IBOutlet var lblProductName: UILabel!
    @IBOutlet var lblPrice: UILabel!
    @IBOutlet var lblPriceBeforeSale: UILabel!
    @IBOutlet var lblDiscountPercent: UILabel!
    @IBOutlet var viewDiscountTag: UIView!
    @IBOutlet weak var viewPricePreSale: UIStackView!

    // MARK: - life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    // MARK: - setup
    func fillData(_ item: ProductRealmEntity) {
        let imagesArray = Array(item.images)
        if (imagesArray.count > 0) {
            imvProductImage.setImageWithPlaceholder(linkImage: imagesArray[0])
        }
        lblProductName.text = item.name
        lblPrice.text = Utils.convertPriceToText(price: item.price)
        lblPriceBeforeSale.setStrikeThrough(text: Utils.convertPriceToText(price: item.priceBeforeSale) ?? "0")
        if item.price < item.priceBeforeSale {
            viewPricePreSale.isHidden = false;
            let discountPercent = Utils.getPercentOf(price: item.price, presalePrice: item.priceBeforeSale)
            lblDiscountPercent.text = "-\(discountPercent!)"
        } else {
            viewPricePreSale.isHidden = true;
        }
    }
    
}
