//
//  ShoppingCartViewController.swift
//  getirFinalProject
//
//  Created by Okan Aslan on 21.04.2024.
//

import UIKit
import CoreData

protocol ShoppingCartViewContract : UIViewController {
    //func suggestedProductsFetched(productList : [ProductDataModel])
}

//class ShoppingCartViewController: UIViewController, ShoppingCartViewContract, UICollectionViewDelegate, UICollectionViewDataSource, ProductCellButtonDelegate, PopUpViewDelegate, ShoppingCartTableCellDelegate {
class ShoppingCartViewController: UIViewController, ShoppingCartViewContract, PopUpViewDelegate, ShoppingCartTableCellDelegate {
    
    var presenter : ShoppingCartPresentation?
    private var _shoppingList : [ProductDataModel] = [ProductDataModel]()
    //private var _suggestedList : [ProductDataModel] = [ProductDataModel]()
    private var _currentProduct : ProductDataModel = ProductDataModel(id: "", imageURL: "", price: 0, name: "", priceText: "", shortDescription: "", category: "", unitPrice: 0, squareThumbnailURL: "", status: 0, attribute: "", thumbnailURL: "", productCount: 0)

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
    /*
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
     */
    
    private lazy var bottomView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .Theme.white
        return view
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "₺0,00"
        label.textAlignment = .center
        label.font = UIFont(name: "OpenSans-Bold", size: 20)
        label.textColor = .Theme.primaryColor  // Makes the price stand out
        label.layer.cornerRadius = 10
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.Theme.shadowGray.cgColor
        return label
    }()
    
    
    private lazy var completeOrderButton : CustomRoundedButton = {
        let button = CustomRoundedButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Siparişi Tamamla", for: .normal)
        button.backgroundColor = UIColor.Theme.primaryColor
        button.setTitleColor(.Theme.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 14)
        button.addTarget(self, action: #selector(completeOrderTapped), for: .touchUpInside)
        button.setRoundedCorners(corners: [.topLeft,.bottomLeft], radius: 10)
        return button
    }()
    
    private lazy var popUpView = PopUpView(frame: .zero)
    
    @objc func completeOrderTapped(){
        print("tapped")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //presenter?.fetchSuggestedProducts()
        popUpView.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        /*
        horizontalCollectionView.dataSource = self
        horizontalCollectionView.delegate = self
         */
        setupUI()
        _shoppingList = CoreDataStack.shared.fetchProducts().map({ product in
            ProductDataModel(id: product.id ?? "-1", imageURL: product.imageURL, price: product.price, name: product.name, priceText: product.priceText, shortDescription: "", category: "", unitPrice: 0.0, squareThumbnailURL: "", status: 0, attribute: product.productAttr, thumbnailURL: "", productCount: Int(product.count))
        })
        updateBasketPrice()
    }
    
    func updateBasketPrice(){
        priceLabel.text =  "\(NumberFormatterUtility.formatNumber( CoreDataStack.shared.calculateTotalPrice()))"
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
        /*
        view.addSubview(horizontalCollectionView)
        horizontalCollectionView.topAnchor.constraint(equalTo: suggestedProductsLabel.bottomAnchor, constant: 12).isActive = true
        horizontalCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        horizontalCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        horizontalCollectionView.heightAnchor.constraint(equalToConstant: 185).isActive = true
        */
        view.addSubview(bottomView)
        bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        bottomView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        bottomView.addSubview(completeOrderButton)
        completeOrderButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 12).isActive = true
        completeOrderButton.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 12).isActive = true
        completeOrderButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        completeOrderButton.widthAnchor.constraint(equalToConstant: 250).isActive = true
        
        bottomView.addSubview(priceLabel)
        priceLabel.topAnchor.constraint(equalTo: completeOrderButton.topAnchor).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: completeOrderButton.trailingAnchor).isActive = true
        priceLabel.bottomAnchor.constraint(equalTo: completeOrderButton.bottomAnchor).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -10).isActive = true
        //completeOrderButton.setRoundedCorners(corners: [.topLeft,.bottomLeft], radius: 10)
        
        //button.setRoundedCorners(corners: [.topLeft,.bottomLeft], radius: 10)
        
        //suggestedProductsLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
    }
    /*
    func suggestedProductsFetched(productList: [ProductDataModel]) {
        _suggestedList = productList
        print(_suggestedList)
        DispatchQueue.main.async {
            self.horizontalCollectionView.reloadData()
        }
    }
     */
    
    @objc func exitButtonTapped(){
        presenter?.back()
    }
    
    @objc func garbageButtonTapped(){
        view.addSubview(popUpView)
        //popUpView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        popUpView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        popUpView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        popUpView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        popUpView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        //popUpView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        print("garbage Tapped")
    }
    
    func buttonYesTapped() {
        CoreDataStack.shared.deleteAllProducts()
        popUpView.removeFromSuperview()
        reloadTableView()
        updateBasketPrice()
    }
    
    func buttonNoTapped() {
        popUpView.removeFromSuperview()
    }

    /*
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
        _currentProduct = _suggestedList[indexPathForHorizontal ?? 0]
        print("currentProductName : \(_currentProduct.name ?? "bos")")
        //var product = ProductDataModel(id: "", imageURL: nil, price: nil, name: nil, priceText: nil, shortDescription: nil, category: nil, unitPrice: nil, squareThumbnailURL: nil, status: nil, attribute: nil, thumbnailURL: nil, productCount: 0)
        
    }
    */
    
}

extension ShoppingCartViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _shoppingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingCartTableViewCell.identifier) as? ShoppingCartTableViewCell{
            cell.configure(product: _shoppingList[indexPath.row])
            cell.delegate = self
            return cell
        }else{
            return UITableViewCell(frame: .zero)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    /*
    func productCountDidUpdate(in cell: UICollectionViewCell, newCount: Int) {
        //print("newCount : \(newCount), product : \(_currentProduct.name ?? "boş")")
        var indexPathForHorizontal : Int?
        indexPathForHorizontal = self.horizontalCollectionView.indexPath(for: cell)?.row
        _currentProduct = _suggestedList[indexPathForHorizontal ?? 0]
                CoreDataStack.shared.addProduct(product: _currentProduct, count: newCount)
        priceLabel.text =  "\(NumberFormatterUtility.formatNumber( CoreDataStack.shared.calculateTotalPrice()))"
        reloadTableView()
    }
    */
    func tableCellCountUpdated(cell : UITableViewCell,count: Int) {
        /*
         var indexPathForHorizontal : Int?
         indexPathForHorizontal = self.horizontalCollectionView.indexPath(for: cell)?.row
         _currentProduct = _suggestedList[indexPathForHorizontal ?? 0]
         */
        var index : Int?
        index = self.tableView.indexPath(for: cell)?.row
        _currentProduct = _shoppingList[index ?? 0]
        print("currentProduct : \(_currentProduct.name) and count : \(_currentProduct.getProductCount())")
        /*
        if _currentProduct.getProductCount() == 0{
            _shoppingList.remove(at: index ?? 0)
        }
         */
        CoreDataStack.shared.addProduct(product: _currentProduct, count: count)
        priceLabel.text =  "\(NumberFormatterUtility.formatNumber(CoreDataStack.shared.calculateTotalPrice()))"
        //reloadTableView()
    }
    
    func reloadTableView(){
        _shoppingList = CoreDataStack.shared.fetchProducts().map({ product in
            ProductDataModel(id: product.id ?? "-1", imageURL: product.imageURL, price: product.price, name: product.name, priceText: product.priceText, shortDescription: "", category: "", unitPrice: 0.0, squareThumbnailURL: "", status: 0, attribute: product.productAttr, thumbnailURL: "", productCount: Int(product.count))
        })
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
         
    }
    
    
}
/*
extension ShoppingCartViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat = 110
        let cellHeight: CGFloat = 150
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
*/
