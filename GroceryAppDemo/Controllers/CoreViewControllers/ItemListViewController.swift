//
//  SubCategoryViewController.swift
//  GroceryAppDemo
//
//  Created by Bhagyesh Desai on 09/12/23.
//

import UIKit

class ItemListViewController: BaseScreenWithSearchBar {
    
    private var titleString: String = "Title"
    private var items: [ItemModel] = [ItemModel]()
    
    private let itemListTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(ItemTableViewCell.self, forCellReuseIdentifier: ItemTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemListTableView.delegate = self
        itemListTableView.dataSource = self
        setupUI()
    }
    
    private func setupUI() {
        titleLabel.text = titleString
        self.tabBarController!.tabBar.isHidden = true
        view.addSubview(itemListTableView)
        applyConstraints()
    }
    
    private func applyConstraints() {
        let mainFeedConstraints = [
            itemListTableView.topAnchor.constraint(equalTo: customSearchBar.bottomAnchor, constant: 10),
            itemListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            itemListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            itemListTableView.heightAnchor.constraint(equalToConstant: CGFloat((150 * items.count)+500))
        ]
        
        NSLayoutConstraint.activate(mainFeedConstraints)
    }
    
    internal func configure(with items: [ItemModel], categoryName: String) {
        titleString = categoryName
        self.items = items
    }
    
}

extension ItemListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.identifier, for: indexPath) as? ItemTableViewCell else {
            return UITableViewCell()
        }
        
        let item = items[indexPath.row]
        let listItemViewModel = ListItemViewModel(itemThumbnailImageUrl: item.thumbnailImage!, itemName: item.typeName!, itemPricePerPiece: item.pricePerPiece, itemPricePerKg: item.pricePerKg)
        cell.configureCell(with: listItemViewModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = items[indexPath.row]
        DispatchQueue.main.async {
            let itemDescriptionVC = ItemDescriptionViewController()
            itemDescriptionVC.configure(with: item)
            self.navigationController?.pushViewController(itemDescriptionVC, animated: true)
        }
    }
}
