//
//  SlideImage.swift
//  TekoMission
//
//  Created by linhvt on 6/29/19.
//  Copyright © 2019 ntq. All rights reserved.
//

import UIKit

class SlideImageView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var imvProImage: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    private func commonInit() {
        Bundle.main.loadNibNamed("SlideImageView", owner: self, options: nil)
        self.addSubview(contentView)
        self.contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

    func fillData(item: String) {
        imvProImage.setImageWithPlaceholder(linkImage: item)
    }

}
