//
//  ListItemViewModel.swift
//  GroceryAppDemo
//
//  Created by Bhagyesh Desai on 09/12/23.
//

import Foundation

// Data model for populating cells of ItemListTableView
struct ListItemViewModel {
    
    let itemThumbnailImageUrl: String
    let itemName: String
    let itemPricePerPiece: Double?
    let itemPricePerKg: Double?
}
