//
//  Extensions.swift
//  GroceryAppDemo
//
//  Created by Bhagyesh Desai on 09/12/23.
//

import UIKit

extension UIImageView {
    func loadImageFromURL(from url: URL, completion: (() -> Void)? = nil) {

        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if let error = error {
                print("Error downloading image: \(error.localizedDescription)")
                completion?()
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                print("No data or unable to create image from data")
                DispatchQueue.main.async {
                    self?.image = UIImage(systemName: "photo.fill")
                    completion?()
                }
                return
            }
            
            DispatchQueue.main.async {
                self?.image = image
                completion?()
            }
        }
        task.resume()
    }
}
