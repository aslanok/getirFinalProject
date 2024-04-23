//
//  ShoppingCartViewController.swift
//  getirFinalProject
//
//  Created by Okan Aslan on 21.04.2024.
//

import UIKit
import CoreData

protocol ShoppingCartViewContract : UIViewController {
    func suggestedProductsFetched(productList : [ProductDataModel])
}

class ShoppingCartViewController: UIViewController, ShoppingCartViewContract, UICollectionViewDelegate, UICollectionViewDataSource, ProductCellButtonDelegate {
    
    var presenter : ShoppingCartPresentation?
    private var _shoppingList : [ProductDataModel] = [ProductDataModel]()
    private var _suggestedList : [ProductDataModel] = [ProductDataModel]()
    
    private lazy var headerView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .Theme.primaryColor
        return view
    }()
    
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sepetim"
        label.font = UIFont(name: "OpenSans-Bold", size: 14)
        label.textAlignment = .center
        label.textColor = .Theme.white
        return label
    }()
    
    private lazy var exitButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
        button.setImage(UIImage(named: "exitIcon"), for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    private lazy var garbageButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(garbageButtonTapped), for: .touchUpInside)
        button.setImage(UIImage(named: "garbageIcon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .clear
        return button
    }()
    
    private lazy var tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .Theme.white
        tableView.separatorColor = .Theme.seperatorGray
        tableView.showsVerticalScrollIndicator = false
        tableView.register(ShoppingCartTableViewCell.self, forCellReuseIdentifier: ShoppingCartTableViewCell.identifier)
        return tableView
    }()
    
    private lazy var suggestedProductsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .Theme.darkText
        label.textAlignment = .left
        label.text = "Önerilen Ürünler"
        label.font = UIFont(name: "OpenSans-SemiBold", size: 12)
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var horizontalCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        //layout.itemSize = CGSize(width: 140, height: 140) // Adjust size as needed
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .Theme.white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: "ProductCell")
        return collectionView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.fetchSuggestedProducts()
        tableView.delegate = self
        tableView.dataSource = self
        horizontalCollectionView.dataSource = self
        horizontalCollectionView.delegate = self
        setupUI()
        _shoppingList = fetchProducts().map({ product in
            ProductDataModel(id: product.id ?? "-1", imageURL: product.imageURL, price: product.price, name: product.name, priceText: product.priceText, shortDescription: "", category: "", unitPrice: 0.0, squareThumbnailURL: "", status: 0, attribute: product.productAttr, thumbnailURL: "", productCount: Int(product.count))
        })
    }
    
    func setupUI(){
        view.backgroundColor = .Theme.viewBackgroundColor
        
        view.addSubview(headerView)
        headerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        headerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        
        headerView.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12).isActive = true
        
        headerView.addSubview(exitButton)
        exitButton.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10).isActive = true
        exitButton.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -10).isActive = true
        exitButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        exitButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        headerView.addSubview(garbageButton)
        garbageButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -12).isActive = true
        garbageButton.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -10).isActive = true
        garbageButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        garbageButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        view.addSubview(suggestedProductsLabel)
        suggestedProductsLabel.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20).isActive = true
        suggestedProductsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        suggestedProductsLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        view.addSubview(horizontalCollectionView)
        horizontalCollectionView.topAnchor.constraint(equalTo: suggestedProductsLabel.bottomAnchor, constant: 12).isActive = true
        horizontalCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        horizontalCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        horizontalCollectionView.heightAnchor.constraint(equalToConstant: 185).isActive = true
        
        
        //suggestedProductsLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
    }
    
    func suggestedProductsFetched(productList: [ProductDataModel]) {
        _suggestedList = productList
        print(_suggestedList)
        DispatchQueue.main.async {
            self.horizontalCollectionView.reloadData()
        }
    }
    
    func fetchProducts() -> [Product] {
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()

        do {
            return try CoreDataStack.shared.context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }
    
    @objc func exitButtonTapped(){
        presenter?.back()
    }
    
    @objc func garbageButtonTapped(){
        print("garbage Tapped")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _suggestedList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCell else {
            fatalError("Unable to dequeue ProductCell")
        }
        cell.configure(with: _suggestedList[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func didTapPlusButton(in cell: UICollectionViewCell) {
        var indexPathForHorizontal : Int?
        indexPathForHorizontal = self.horizontalCollectionView.indexPath(for: cell)?.row
        var product = ProductDataModel(id: "", imageURL: nil, price: nil, name: nil, priceText: nil, shortDescription: nil, category: nil, unitPrice: nil, squareThumbnailURL: nil, status: nil, attribute: nil, thumbnailURL: nil, productCount: 0)
        
        
    }
    
}

extension ShoppingCartViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _shoppingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingCartTableViewCell.identifier) as? ShoppingCartTableViewCell{
            cell.configure(product: _shoppingList[indexPath.row])
            return cell
        }else{
            return UITableViewCell(frame: .zero)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}

extension ShoppingCartViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat = 110
        let cellHeight: CGFloat = 150
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

