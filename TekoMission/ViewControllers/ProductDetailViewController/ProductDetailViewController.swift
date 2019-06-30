//
//  ProductDetailViewController.swift
//  TekoMission
//
//  Created by linhvt on 6/28/19.
//  Copyright © 2019 ntq. All rights reserved.
//

import UIKit
import UIColor_Hex_Swift

enum InfoState {
    case description
    case techInfo
    case priceComparison
}

class ProductDetailViewController: BaseViewController {

    // MARK: - outlets
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblOrderNum: UILabel!
    @IBOutlet weak var viewCarousel: iCarousel!
    @IBOutlet weak var lblProName: UILabel!
    @IBOutlet weak var lblProCode: UILabel!
    @IBOutlet weak var viewOutOfStock: CustomView!
    @IBOutlet weak var lblProPrice: UILabel!
    @IBOutlet weak var lblProPriceBeforeSale: UILabel!
    @IBOutlet weak var viewProTag: UIView!
    @IBOutlet weak var lblProDiscountPercent: UILabel!
    @IBOutlet weak var lineProDescription: UIImageView!
    @IBOutlet weak var btnProDescription: UIButton!
    @IBOutlet weak var btnProTechInfo: UIButton!
    @IBOutlet weak var lineProTechInfo: UIImageView!
    @IBOutlet weak var btnProPriceComparison: UIButton!
    @IBOutlet weak var lineProPriceComparison: UIImageView!

    @IBOutlet weak var tableTechInfo: UITableView!
    @IBOutlet weak var lcHeightTableTechInfo: NSLayoutConstraint!
    @IBOutlet weak var viewShowMore: UIView!
    @IBOutlet weak var collectionProSameKind: UICollectionView!
    @IBOutlet weak var lblOrderNumBottom: UILabel!
    @IBOutlet weak var lblTotalPrice: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!

    // MARK: - variables
    var product: ProductRealmEntity?
    var productSku = ""
    var currentOrderNum: Int = 0
    var currentInfoState: InfoState = .techInfo
    var isConfigCarousel = false
    var imagesList: [String] = []
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.default
    }

    // MARK: - setup
    override func initComponents() {
        super.initComponents()
        self.setupTableView()
        self.setupCollectionView()
        self.setupCarousel()
        self.getProductInfoFromDB()
    }

    override func setupNavigationBar() {
        super.setupNavigationBar()
    }

    func getProductInfoFromDB() {
        self.product = DBManager.shared.getProductBySku(self.productSku)
        if let product = self.product {
            self.fillData(product)
            self.setupPageControl()
        }
    }

    func fillData(_ product: ProductRealmEntity) {
        lblName.text = product.name
        let price = Utils.convertPriceToText(price: product.price) ?? "0"
        lblPrice.text = "\(price)đ"
        lblOrderNum.text = "\(currentOrderNum)"
        lblProName.text = product.name
        lblProCode.text = product.sku
        lblProPrice.text = Utils.convertPriceToText(price: product.price)
        lblProPriceBeforeSale.setStrikeThrough(text: Utils.convertPriceToText(price: product.priceBeforeSale) ?? "0")
        if product.price < product.priceBeforeSale {
            viewProTag.isHidden = false;
            let discountPercent = Utils.getPercentOf(price: product.price, presalePrice: product.priceBeforeSale)
            lblProDiscountPercent.text = "-\(discountPercent!)"
            lblProPriceBeforeSale.isHidden = false;
        } else {
            viewProTag.isHidden = true;
            lblProPriceBeforeSale.isHidden = true;
        }
        self.setStateForProInfo(state: .techInfo)
        lblOrderNumBottom.text = "\(currentOrderNum)"
        lblTotalPrice.text = Utils.convertPriceToText(price: 0)
        let imagesArray = Array(product.images)
        self.imagesList = imagesArray
        self.reloadCarousel()
    }

    func setStateForProInfo(state: InfoState) {
        btnProDescription.isSelected = (state == .description)
        btnProTechInfo.isSelected = (state == .techInfo)
        btnProPriceComparison.isSelected = (state == .priceComparison)

        lineProDescription.isHidden = (state != .description)
        lineProTechInfo.isHidden = (state != .techInfo)
        lineProPriceComparison.isHidden = (state != .priceComparison)

        currentInfoState = state
    }

    func updateCurrentOrder() {
        if let product = self.product {
            lblOrderNum.text = "\(currentOrderNum)"
            lblOrderNumBottom.text = "\(currentOrderNum)"
            let totalPrice = product.price * currentOrderNum
            lblTotalPrice.text = Utils.convertPriceToText(price:totalPrice)
        }
    }

    // MARK: - actions
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func orderReviewAction(_ sender: Any) {
    }

    @IBAction func showMoreAction(_ sender: Any) {
    }

    @IBAction func descreaseOrderNumAction(_ sender: Any) {
        guard currentOrderNum > 0 else {
            return
        }
        currentOrderNum = currentOrderNum - 1
        self.updateCurrentOrder()
    }

    @IBAction func increaseOrderNumAction(_ sender: Any) {
        currentOrderNum = currentOrderNum + 1
        self.updateCurrentOrder()
    }

    @IBAction func paymentAction(_ sender: Any) {
    }

}

// MARK: - tableView delegate & datasource
extension ProductDetailViewController: UITableViewDelegate, UITableViewDataSource {
    fileprivate func setupTableView() {
        self.tableTechInfo.separatorStyle = .none
        self.tableTechInfo.registerCellNib(TechInfoTableViewCell.self)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TechInfoTableViewCell.height
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TechInfoTableViewCell = tableView.dequeueReusableCell(TechInfoTableViewCell.self, idxPath: indexPath)
//        cell.fillData()
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}


// MARK: - collectionView delegate & datasource
extension ProductDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    fileprivate func setupCollectionView() {
        collectionProSameKind.registerCellNib(ProSameKindCollectionViewCell.self)
        collectionProSameKind.showsHorizontalScrollIndicator = false
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: ProSameKindCollectionViewCell.width, height: ProSameKindCollectionViewCell.height)
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        collectionProSameKind.collectionViewLayout.invalidateLayout()
        collectionProSameKind.setCollectionViewLayout(layout, animated: false)
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ProSameKindCollectionViewCell = collectionView.dequeueReusableCell(ProSameKindCollectionViewCell.self, idxPath: indexPath)
//        cell.fillData(word: listWords[indexPath.row])
        return cell
    }
}

// MARK: - iCarousel delegate & datasource
extension ProductDetailViewController: iCarouselDelegate, iCarouselDataSource {
    fileprivate func setupCarousel() {
        viewCarousel.type = iCarouselType.linear
        viewCarousel.isPagingEnabled = true
        viewCarousel.delegate = self
        viewCarousel.dataSource = self
        viewCarousel.bounces = false
        imagesList = []
        isConfigCarousel = true
    }

    func reloadCarousel() {
        if isConfigCarousel {
            viewCarousel.reloadData()
        }
    }

    fileprivate func setupPageControl() {
        self.pageControl.numberOfPages = self.imagesList.count
        self.pageControl.currentPage = 0
        self.pageControl.pageIndicatorTintColor = UIColor(TMColor.PaleGrey)
        self.pageControl.currentPageIndicatorTintColor = UIColor(TMColor.Tomato)
    }

    fileprivate func activeDots(index: Int) {
        self.pageControl.currentPage = index
    }

    func numberOfItems(in carousel: iCarousel) -> Int {
        return self.imagesList.count
    }

    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        var slideImageView: SlideImageView
        if view == nil {
            slideImageView = SlideImageView(frame: CGRect(x: 0, y: 0, width: carousel.frame.size.width, height: carousel.frame.size.height))
            slideImageView.layer.masksToBounds = true
        } else {
            slideImageView = view as! SlideImageView
        }
        if (self.imagesList.count > 0) {
            let linkImage = self.imagesList[index]
            slideImageView.fillData(item: linkImage)
        }
        return slideImageView
    }

    func carousel(_ carousel: iCarousel, itemTransformForOffset offset: CGFloat, baseTransform transform: CATransform3D) -> CATransform3D {
        let transform = CATransform3DRotate(transform, CGFloat(.pi / 8.0), 0.0, 1.0, 0.0)
        return CATransform3DTranslate(transform, 0.0, 0.0, offset * carousel.itemWidth)
    }

    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        switch option {
        case iCarouselOption.spacing:
            return value * 1.0
        case iCarouselOption.fadeMax:
            if carousel.type == iCarouselType.custom {
                return 0.0
            }
            return value
        default:
            return value
        }
    }

    func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
        self.activeDots(index: carousel.currentItemIndex)
    }

    func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {

    }
}
