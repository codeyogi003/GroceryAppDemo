//
//  CategoriesViewController.swift
//  GroceryAppDemo
//
//  Created by Bhagyesh Desai on 09/12/23.
//

import UIKit

class CategoryViewController: BaseScreenWithSearchBar {
    
    private var categories: [CategoryModel] = [CategoryModel]()
    
    private var categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 160, height: 210)
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        setupUI()
    }
    
    private func setupUI() {
        
        view.addSubview(categoryCollectionView)
        self.tabBarController!.tabBar.items![0].image = UIImage(named: ResourcesEnum.GridHighlightedIcon.rawValue)
        titleLabel.text = ResourcesEnum.CategoryPageTitleLabel.fetchLocalizedString()
        applyConstraints()
        loadMainFeed()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.tabBarController!.tabBar.items![0].image = UIImage(named: ResourcesEnum.GridIcon.rawValue)
    }
    
    private func applyConstraints() {
        
        let mainFeedConstraints = [
            categoryCollectionView.topAnchor.constraint(equalTo: customSearchBar.bottomAnchor, constant: 10),
            categoryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoryCollectionView.heightAnchor.constraint(equalToConstant: 600)
        ]
        NSLayoutConstraint.activate(mainFeedConstraints)
    }
    
    private func loadMainFeed() {
        APIFetcher.shared.fetchAllCategories() { [ weak self ] result in
            switch result {
            case .success(let categoriesArray):
                self?.categories = categoriesArray
                DispatchQueue.main.async {
                    self?.categoryCollectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension CategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as? CategoryCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        var categoryViewModel: CategoryViewModel

        categoryViewModel = CategoryViewModel(categoryImageUrl: categories[indexPath.row].categoryImage ?? "",
                                              categoryName: categories[indexPath.row].categoryName ?? "",
                                              totalItems: categories[indexPath.row].totalItems)
        
        cell.configureCell(with: categoryViewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let category = categories[indexPath.row]
        guard let categoryType = category.categoryType else {
            return
        }
        guard let categoryName = category.categoryName else {
            return
        }
        APIFetcher.shared.fetchAllItems(with: categoryType) { [ weak self ] result in
            switch result {
            case .success(let itemArray):
                let itemsInCategoryResult = ItemsInCategoryResponse(result: itemArray)
                guard let strongSelf = self else { return }
                DispatchQueue.main.async {
                let itemListVC = ItemListViewController()
                itemListVC.configure(with: itemsInCategoryResult.result, categoryName: categoryName)
                    strongSelf.navigationController?.pushViewController(itemListVC, animated: true)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
