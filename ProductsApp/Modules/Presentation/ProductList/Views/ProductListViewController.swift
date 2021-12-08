//
//  ProductListViewController.swift
//  ProductsApp
//
//  Created by Khoubaib Chamekh on 12/8/21.
//

import UIKit

class ProductListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    var viewModel: ProductListViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
