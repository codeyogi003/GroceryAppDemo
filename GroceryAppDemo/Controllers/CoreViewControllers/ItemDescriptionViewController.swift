//
//  ItemDescriptionViewController.swift
//  GroceryAppDemo
//
//  Created by Bhagyesh Desai on 09/12/23.
//

import UIKit

class ItemDescriptionViewController: BaseScreen {
    
    private var screenWidth: CGFloat = 0.0
    private var screenHeight: CGFloat = 0.0
    private var itemImagesCarousel = [String]()
    
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = true
        scrollView.contentMode = .scaleToFill
        return scrollView
    }()
    
    private var pageControl: UIPageControl!
    
    private let bottomSectionView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: ColorsEnum.BackgroundGrey.rawValue)
        view.layer.cornerRadius = 50
        view.layer.masksToBounds = true
        return view
    }()
    
    private let itemNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.setContentHuggingPriority(.required, for: .vertical)
        label.text = ResourcesEnum.TestingLabel.fetchLocalizedString()
        label.textColor = UIColor(named: ColorsEnum.TextColorPrimary.rawValue)
        label.textAlignment = .center
        return label
    }()
    
    private let itemPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.required, for: .vertical)
        label.text = ResourcesEnum.TestingLabel.fetchLocalizedString()
        label.textColor = UIColor(named: ColorsEnum.TextColorPrimary.rawValue)
        label.textAlignment = .center
        return label
    }()
    
    private let itemWeightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ResourcesEnum.TestingLabel.fetchLocalizedString()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textColor = UIColor(named: ColorsEnum.GoAheadGreen.rawValue)
        label.textAlignment = .center
        return label
    }()
    
    private let countryOfOriginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.required, for: .vertical)
        label.text = "NA"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = UIColor(named: ColorsEnum.TextColorPrimary.rawValue)
        label.textAlignment = .center
        return label
    }()
    
    private let itemDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.text = ResourcesEnum.TestingLabel.fetchLocalizedString()
        label.textColor = UIColor(named: ColorsEnum.TextColorPrimary.rawValue)
        label.numberOfLines = 0
        label.contentMode = .top
        label.textAlignment = .left
        return label
    }()
    
    private let likeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: ColorsEnum.BackgroundWhite.rawValue)
        button.setImage(UIImage(named: ResourcesEnum.HeartIcon.rawValue), for: .normal)
        button.imageView?.contentMode = .scaleToFill
        button.layer.cornerRadius = UtilityClass.buttonCornerRadius
        return button
    }()
    
    private let addToCartButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: ColorsEnum.GoAheadGreen.rawValue)
        button.setTitleColor(UIColor(named: ColorsEnum.TextColorSecondary.rawValue), for: .normal)
        
        let attributedString = NSAttributedString(string: "  \(ResourcesEnum.AddToCartButtonLabel.fetchLocalizedString())", attributes: [.font: UIFont.systemFont(ofSize: 15, weight: .regular)])
        button.setAttributedTitle(attributedString, for: .normal)
        button.layer.cornerRadius = UtilityClass.buttonCornerRadius
        
        button.setImage(UIImage(named: ResourcesEnum.ShoppingCartIcon.rawValue)?.withTintColor(UIColor(named: ColorsEnum.BackgroundWhite.rawValue)!), for: .normal)
        button.setImage(UIImage(named: ResourcesEnum.ShoppingCartIcon.rawValue)?.withTintColor(UIColor(named: ColorsEnum.BackgroundWhite.rawValue)!), for: .highlighted)
        button.imageView?.contentMode = .left
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screenWidth = view.bounds.width
        screenHeight = view.bounds.height
        setupUI()
    }
    
    private func setupUI() {
        
        self.tabBarController!.tabBar.isHidden = true
        self.navigationController?.navigationBar.backgroundColor = .clear
        likeButton.addTarget(self, action: #selector(likeButtonAction(_:)), for: .touchUpInside)
        addToCartButton.addTarget(self, action: #selector(addToCartButtonAction(_:)), for: .touchUpInside)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(itemImagesCarousel.count), height: screenHeight*0.5)
        scrollView.delegate = self
        setupScrollView()
        
        view.addSubview(scrollView)
        view.addSubview(pageControl)
        view.addSubview(bottomSectionView)
        bottomSectionView.addSubview(itemNameLabel)
        bottomSectionView.addSubview(itemPriceLabel)
        bottomSectionView.addSubview(itemWeightLabel)
        bottomSectionView.addSubview(countryOfOriginLabel)
        bottomSectionView.addSubview(itemDescriptionLabel)
        bottomSectionView.addSubview(likeButton)
        bottomSectionView.addSubview(addToCartButton)
        
        applyConstraints()
    }
    
    private func setupScrollView() {
        for (index, imageUrlString) in itemImagesCarousel.enumerated() {
            let imageView = UIImageView(frame: CGRect(x: view.frame.width * CGFloat(index), y: 0, width: view.frame.width, height: screenHeight*0.5))
            guard let imageUrl = URL(string: imageUrlString) else {
                return
            }
            imageView.loadImageFromURL(from: imageUrl, completion: nil)
            imageView.contentMode = .scaleToFill
            scrollView.addSubview(imageView)
        }
        
        pageControl = UIPageControl(frame: CGRect(x: 0, y: view.frame.height - (view.frame.height * 0.65), width: view.frame.width, height: 50))
        pageControl.numberOfPages = itemImagesCarousel.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.gray
        pageControl.currentPageIndicatorTintColor = UIColor.black
    }
    
    private func applyConstraints() {
        let bottomSectionViewConstraints = [
            bottomSectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomSectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomSectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomSectionView.heightAnchor.constraint(equalToConstant: screenHeight*0.6)
        ]
        
        let itemNameLabelConstraints = [
            itemNameLabel.topAnchor.constraint(equalTo: bottomSectionView.topAnchor, constant: 50),
            itemNameLabel.leadingAnchor.constraint(equalTo: bottomSectionView.leadingAnchor, constant: 20)
        ]
        
        let itemPriceLabelConstraints = [
            itemPriceLabel.topAnchor.constraint(equalTo: itemNameLabel.bottomAnchor, constant: 20),
            itemPriceLabel.leadingAnchor.constraint(equalTo: bottomSectionView.leadingAnchor, constant: 20)
        ]
        
        let itemWeightLabelConstraints = [
            itemWeightLabel.topAnchor.constraint(equalTo: itemPriceLabel.bottomAnchor, constant: 20),
            itemWeightLabel.leadingAnchor.constraint(equalTo: bottomSectionView.leadingAnchor, constant: 20)
        ]
        
        let countryLabelConstraints = [
            countryOfOriginLabel.topAnchor.constraint(equalTo: itemWeightLabel.bottomAnchor, constant: 20),
            countryOfOriginLabel.leadingAnchor.constraint(equalTo: bottomSectionView.leadingAnchor, constant: 20)
        ]
        
        let itemDescriptionLabelConstraints = [
            itemDescriptionLabel.topAnchor.constraint(equalTo: countryOfOriginLabel.bottomAnchor, constant: 20),
            itemDescriptionLabel.leadingAnchor.constraint(equalTo: bottomSectionView.leadingAnchor, constant: 20),
            itemDescriptionLabel.trailingAnchor.constraint(equalTo: bottomSectionView.trailingAnchor, constant: -60),
            itemDescriptionLabel.bottomAnchor.constraint(equalTo: likeButton.topAnchor, constant: -20)
        ]
        
        let likeButtonConstraints = [
            likeButton.bottomAnchor.constraint(equalTo: bottomSectionView.bottomAnchor, constant: -50),
            likeButton.leadingAnchor.constraint(equalTo: bottomSectionView.leadingAnchor, constant: 20),
            likeButton.heightAnchor.constraint(equalToConstant: 50),
            likeButton.widthAnchor.constraint(equalToConstant: 80),
        ]
        
        let addToCartButtonConstraints = [
            addToCartButton.bottomAnchor.constraint(equalTo: bottomSectionView.bottomAnchor, constant: -50),
            addToCartButton.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: 20),
            addToCartButton.trailingAnchor.constraint(equalTo: bottomSectionView.trailingAnchor, constant: -20),
            addToCartButton.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        let scrollViewConstraints = [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: screenHeight*0.5)
        ]
        
        NSLayoutConstraint.activate(bottomSectionViewConstraints)
        NSLayoutConstraint.activate(itemNameLabelConstraints)
        NSLayoutConstraint.activate(itemPriceLabelConstraints)
        NSLayoutConstraint.activate(itemWeightLabelConstraints)
        NSLayoutConstraint.activate(itemDescriptionLabelConstraints)
        NSLayoutConstraint.activate(countryLabelConstraints)
        NSLayoutConstraint.activate(likeButtonConstraints)
        NSLayoutConstraint.activate(addToCartButtonConstraints)
        NSLayoutConstraint.activate(scrollViewConstraints)

    }
    
    public func configure(with item: ItemModel) {
        
        itemImagesCarousel = item.sliderImages!
        
        itemNameLabel.text = item.typeName
        
        if let itemPrice = item.pricePerPiece {
            itemPriceLabel.attributedText = UtilityClass.shared.attributedStringFormatter(strings: [String(itemPrice), " $/Piece"], attributes: [.init(Font: .systemFont(ofSize: 30, weight: .bold)), .init(Font: .systemFont(ofSize: 25, weight: .light))])
        } else {
            itemPriceLabel.attributedText = UtilityClass.shared.attributedStringFormatter(strings: [String(item.pricePerKg!), " $/Kg"], attributes: [.init(Font: .systemFont(ofSize: 30, weight: .bold)), .init(Font: .systemFont(ofSize: 25, weight: .light))])
        }
        
        itemWeightLabel.text = "~\(item.weightPerPiece!) gr/piece"
        
        itemDescriptionLabel.text = item.description
    }
    
    @objc private func likeButtonAction(_ sender: UIButton) {
        if(likeButton.imageView?.image == UIImage(named: ResourcesEnum.HeartIcon.rawValue)) {
            likeButton.setImage(UIImage(named: ResourcesEnum.HeartHighlighted.rawValue), for: .normal)
        } else {
            likeButton.setImage(UIImage(named: ResourcesEnum.HeartIcon.rawValue), for: .normal)
        }
    }
    
    @objc private func addToCartButtonAction(_ sender: UIButton) {
        let checkoutVC = CheckoutViewController()
        self.navigationController?.pushViewController(checkoutVC, animated: true)
    }
    
}

extension ItemDescriptionViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}
