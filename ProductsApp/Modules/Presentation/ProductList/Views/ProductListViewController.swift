//
//  ProductListViewController.swift
//  ProductsApp
//
//  Created by Khoubaib Chamekh on 12/8/21.
//

import UIKit

enum Section {
    case products
}

class ProductListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Typealias
    private typealias DataSource = UITableViewDiffableDataSource<Section, PresentableProduct>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, PresentableProduct>
    // MARK: Properties
    private var viewModel: ProductListViewModelProtocol?
    private var dataSource: DataSource!
    
    convenience init(viewModel: ProductListViewModelProtocol?) {
        self.init()
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureDataSource()
        viewModel?.fetchProducts(completion: { [weak self] result in
            switch result {
            case .success(let products):
                self?.updateSections(products: products)
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        })
    }
    
    //MARK: - Setup UI
    private func configureUI() {
        navigationItem.title = "Products"
    }
    
    private func configureDataSource() {
        dataSource = DataSource(
            tableView: tableView,
            cellProvider: { (tableView, indexPath, product) -> UITableViewCell? in
                UITableViewCell(frame: .zero)
            }
        )
    }
    
    private func updateSections(products: [PresentableProduct]) {
        var snapshot = Snapshot()
        snapshot.appendSections([.products])
        snapshot.appendItems(products)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension ProductListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
