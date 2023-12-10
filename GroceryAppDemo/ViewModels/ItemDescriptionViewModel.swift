//
//  ItemDescriptionViewModel.swift
//  GroceryAppDemo
//
//  Created by Bhagyesh Desai on 09/12/23.
//

import Foundation

struct ItemDescriptionViewModel {
    
    let itemThumbnailImageUrl: String
    let carouselImageUrls: [String]
    let itemName: String
    let itemPricePerPiece: String
    let itemWeightPerPiece: String
    let itemDescription: String
    // let countryOfOrigin - String not present in API response
}
