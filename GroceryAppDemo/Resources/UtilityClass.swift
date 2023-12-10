//
//  ConstantsClass.swift
//  GroceryAppDemo
//
//  Created by Bhagyesh Desai on 08/12/23.
//

import UIKit

final class UtilityClass {
    
    static let shared = UtilityClass()
    
    static let buttonCornerRadius: CGFloat = 15
    static let searchBarCornerRadius: CGFloat = 25
    
    static let BASE_URL = "http://ec2-15-207-119-97.ap-south-1.compute.amazonaws.com:3000"
    
    /*
     Description: This function returns attributed string after applying all the specified attributed
     Params: strings - Array of strings, attributed - Array of StringAttributeModel
     Return Type: Attributed string
     */
    public func attributedStringFormatter(strings: [String], attributes: [StringAttributeModel?]) -> NSAttributedString {
        
        let attributedFinalString = NSMutableAttributedString()
        
        for i in 0..<strings.count {
            let string = NSMutableAttributedString(string: strings[i])
            let attribute = attributes[i]
            if let font = attribute?.Font {
                string.addAttributes([NSAttributedString.Key.font: font], range: NSRange(location: 0, length: string.length))
                }
            if let foregroundColor = attribute?.ForegroundColor {
                string.addAttributes([NSAttributedString.Key.foregroundColor: foregroundColor], range: NSRange(location: 0, length: string.length))
                }
            attributedFinalString.append(string)
        }
        return attributedFinalString
    }

}

class CustomTabBar: UITabBar {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let cornerRadius: CGFloat = 20.0
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)
        ).cgPath
        layer.mask = maskLayer
    }
}
