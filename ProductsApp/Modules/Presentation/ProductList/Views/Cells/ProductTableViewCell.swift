//
//  ProductTableViewCell.swift
//  ProductsApp
//
//  Created by Khoubaib Chamekh on 7/2/2022.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    //MARK: IBOutlets
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var previewImageView: UIImageView!
    //MARK: Properties
    static let identifier = "ProductTableViewCell"
    
    func configure(using content: PresentableProduct) {
        descriptionLabel.text = content.description
        previewImageView.load(withUrl: content.imageURL)
    }
}
