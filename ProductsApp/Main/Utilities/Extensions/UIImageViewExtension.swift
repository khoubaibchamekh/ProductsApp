//
//  UIImageViewExtension.swift
//  ProductsApp
//
//  Created by Khoubaib Chamekh on 7/2/2022.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    func load(withUrl url: URL?, placeholder: String? = nil) {
        if let placeholder = placeholder, !placeholder.isEmpty {
            image = UIImage(named: placeholder)
        }
        
        guard let url = url else { return }
        
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString)  {
            image = cachedImage
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { [weak self] data, response, error in
            guard error == nil else { return }
            DispatchQueue.main.async {
                if let data = data, let image = UIImage(data: data) {
                    imageCache.setObject(image, forKey: url.absoluteString as NSString)
                    self?.image = image
                }
            }
        })
        .resume()
    }
}
