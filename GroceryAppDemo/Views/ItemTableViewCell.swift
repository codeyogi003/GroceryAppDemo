//
//  ItemTableViewCell.swift
//  GroceryAppDemo
//
//  Created by Bhagyesh Desai on 09/12/23.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    static let identifier: String = "ItemTableViewCell"
    
    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let itemNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 25, weight: .regular)
        label.textColor = UIColor(named: ColorsEnum.TextColorPrimary.rawValue)
        label.textAlignment = .center
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: ColorsEnum.TextColorPrimary.rawValue)
        label.textAlignment = .center
        return label
    }()
    
    private let extraSpaceView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(named: ColorsEnum.BackgroundGrey.rawValue)
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(itemNameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(extraSpaceView)
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func applyConstraints() {
        let thumbnailImageViewConstraints = [
            thumbnailImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            thumbnailImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            thumbnailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            thumbnailImageView.widthAnchor.constraint(equalToConstant: 150)
        ]
        
        let itemNameLabelConstraints = [
            itemNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            itemNameLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 10)
        ]
        
        let priceLabelConstraints = [
            priceLabel.centerYAnchor.constraint(equalTo: thumbnailImageView.centerYAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 10)
        ]
        
        let extraSpaceViewConstraints = [
            extraSpaceView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            extraSpaceView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            extraSpaceView.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(thumbnailImageViewConstraints)
        NSLayoutConstraint.activate(itemNameLabelConstraints)
        NSLayoutConstraint.activate(priceLabelConstraints)
        NSLayoutConstraint.activate(extraSpaceViewConstraints)
    }
    
    internal func configureCell(with model: ListItemViewModel) {
        guard let thumbnailUrl = URL(string: model.itemThumbnailImageUrl) else {
            return
        }
        thumbnailImageView.loadImageFromURL(from: thumbnailUrl, completion: nil)
        itemNameLabel.text = model.itemName
        
        if let pricePerKg = model.itemPricePerKg {
            let priceUnitString: String = "  $/Kg"
            priceLabel.attributedText = UtilityClass.shared.attributedStringFormatter(strings: [String(pricePerKg), priceUnitString], attributes: [.init(Font: .systemFont(ofSize: 20, weight: .regular)), .init(Font: .systemFont(ofSize: 15, weight: .light))])
        } else {
            let pricePerPiece = model.itemPricePerPiece!
            let priceUnitString: String = "  $/Piece"
            priceLabel.attributedText = UtilityClass.shared.attributedStringFormatter(strings: [String(pricePerPiece), priceUnitString], attributes: [.init(Font: .systemFont(ofSize: 20, weight: .regular)), .init(Font: .systemFont(ofSize: 15, weight: .light))])
        }
    }
    
}
