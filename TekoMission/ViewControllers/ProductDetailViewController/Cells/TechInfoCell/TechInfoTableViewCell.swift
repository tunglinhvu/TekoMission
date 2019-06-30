//
//  TechInfoTableViewCell.swift
//  TekoMission
//
//  Created by linhvt on 6/29/19.
//  Copyright © 2019 ntq. All rights reserved.
//

import UIKit

class TechInfoTableViewCell: UITableViewCell {
    public static let height: CGFloat = 35
    
    // MARK: - outlets
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblValue: UILabel!

    // MARK: - variables

    // MARK: - life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    func fillData(_ attributeGroup: AttributeGroupRealmEntity, withIndex index: Int) {
        lblTitle.text = attributeGroup.name
        lblValue.text = attributeGroup.value
        self.backgroundColor = (index % 2 == 0) ? UIColor(TMColor.PaleGrey) : UIColor.white
    }
}
