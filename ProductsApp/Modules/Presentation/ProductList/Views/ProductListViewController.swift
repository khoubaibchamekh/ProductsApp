//
//  ProductListViewController.swift
//  ProductsApp
//
//  Created by Khoubaib Chamekh on 12/8/21.
//

import UIKit
import RxSwift
import RxCocoa

class ProductListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    private var viewModel: ProductListViewModelProtocol?
    private let disposeBag = DisposeBag()
    
    convenience init(viewModel: ProductListViewModelProtocol?) {
        self.init()
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTableView()
        configureDataSource()
        viewModel?.fetchProducts()
    }
    
    //MARK: - Setup UI
    private func configureUI() {
        navigationItem.title = "Products"
    }
    
    private func configureTableView() {
        tableView.register(
            UINib.init(
                nibName: ProductTableViewCell.identifier,
                bundle: Bundle(for: type(of: self))
            ),
            forCellReuseIdentifier: ProductTableViewCell.identifier
        )
    }
    
    private func configureDataSource() {
        guard let viewModel = self.viewModel else { return }
        
        viewModel
            .tableDataSource
            .bind(
                to: tableView.rx.items(
                    cellIdentifier: ProductTableViewCell.identifier,
                    cellType: ProductTableViewCell.self
                )
            ) { row, product, cell in
                cell.configure(using: product)
            }
            .disposed(by: disposeBag)
    }
}
