//
//  Item.swift
//  GroceryAppDemo
//
//  Created by Bhagyesh Desai on 09/12/23.
//

import Foundation

// This model is for storing per-item-level details
struct ItemModel: Codable {
    
    let typeID: Int
    let typeName: String?
    let description: String?
    let thumbnailImage: String?
    let sliderImages: [String]?
    let pricePerPiece: Double?
    let pricePerKg: Double?
    let weightPerPiece: Double?
}

struct ItemsInCategoryResponse: Codable {
    let result: [ItemModel]
}
