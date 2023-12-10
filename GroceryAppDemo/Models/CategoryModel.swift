//
//  Category.swift
//  GroceryAppDemo
//
//  Created by Bhagyesh Desai on 09/12/23.
//

import Foundation

// This model is for storing per-category-level details
struct CategoryModel: Codable {
    let categoryID: Int
    let categoryType: String?
    let categoryName: String?
    let categoryImage: String?
    let totalItems: Int
}

struct AllCategoriesResponse: Codable {
    let result: [CategoryModel]
}
