//
//  ProductTableViewCell.swift
//  ProductsApp
//
//  Created by Khoubaib Chamekh on 7/2/2022.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    //MARK: IBOutlets
    @IBOutlet weak var brandNameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var previewImageView: UIImageView!
    //MARK: Properties
    static let identifier = "ProductTableViewCell"

    func configure(using content: ProductCellViewModel) {
        brandNameLabel.text = content.brandName
        titleLabel.text = content.name
        priceLabel.text = "\(content.price) €"
        descriptionLabel.text = content.description
        previewImageView.load(withUrl: content.imageURL)
    }
}
