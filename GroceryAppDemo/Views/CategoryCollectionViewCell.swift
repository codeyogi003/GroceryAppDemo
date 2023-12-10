//
//  CategoryCollectionViewCell.swift
//  GroceryAppDemo
//
//  Created by Bhagyesh Desai on 09/12/23.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CategoryCollectionViewCell"
    private var contentViewWidth: CGFloat = 0
    private var contentViewHeight: CGFloat = 0
    
    private let categoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let bottomSectionView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: ColorsEnum.BackgroundWhite.rawValue)
        return view
    }()
    
    private let categoryTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ResourcesEnum.HomePageTitleLabel.fetchLocalizedString()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = UIColor(named: ColorsEnum.TextColorPrimary.rawValue)
        label.textAlignment = .center
        return label
    }()
    
    private let totalCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ResourcesEnum.HomePageTitleLabel.fetchLocalizedString()
        label.font = .systemFont(ofSize: 14, weight: .ultraLight)
        label.textColor = UIColor(named: ColorsEnum.TextColorPrimary.rawValue)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = UtilityClass.buttonCornerRadius
        contentView.clipsToBounds = true
        contentView.addSubview(categoryImageView)
        contentView.addSubview(bottomSectionView)
        bottomSectionView.addSubview(categoryTitleLabel)
        bottomSectionView.addSubview(totalCountLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentViewWidth = contentView.bounds.width
        contentViewHeight = contentView.bounds.height
        applyConstraints()
    }
    
    private func applyConstraints() {
        let categoryImageViewConstraints = [
            categoryImageView.heightAnchor.constraint(equalToConstant: contentViewHeight*0.5),
            categoryImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            categoryImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            categoryImageView.topAnchor.constraint(equalTo: contentView.topAnchor)
        ]
        
        let bottomSectionViewConstraints = [
            bottomSectionView.topAnchor.constraint(equalTo: categoryImageView.bottomAnchor),
            bottomSectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bottomSectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bottomSectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        let titleLabelConstraints = [
            categoryTitleLabel.topAnchor.constraint(equalTo: bottomSectionView.topAnchor, constant: 10),
            categoryTitleLabel.leadingAnchor.constraint(equalTo: bottomSectionView.leadingAnchor, constant: 10)
        ]
        
        let countLabelConstraints = [
            totalCountLabel.topAnchor.constraint(equalTo: categoryTitleLabel.bottomAnchor, constant: 10),
            totalCountLabel.leadingAnchor.constraint(equalTo: bottomSectionView.leadingAnchor, constant: 10)
        ]
        
        NSLayoutConstraint.activate(categoryImageViewConstraints)
        NSLayoutConstraint.activate(bottomSectionViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(countLabelConstraints)
        
    }
    
    public func configureCell(with model: CategoryViewModel) {
        guard let imageUrl = URL(string: model.categoryImageUrl) else {
            return
        }
        categoryImageView.loadImageFromURL(from: imageUrl, completion: nil)
        categoryTitleLabel.text = model.categoryName
        totalCountLabel.text = "(+\(String(model.totalItems)))"
    }
    
}
