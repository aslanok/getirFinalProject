//
//  MainPageViewController.swift
//  getirFinalProject
//
//  Created by Okan Aslan on 16.04.2024.
//

import UIKit
import CoreData

protocol MainPageViewContract : UIViewController{
    //func suggestedProductsFetched(productList : [ProductDataModel])
    //func allProductsFetched(productList : [ProductDataModel])
    func displayTotalPrice(price : Double)
    func reloadHorziontalCollectionView()
    func reloadVerticalCollectionView()
}

class MainPageViewController : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, MainPageViewContract{
    
    private var _count : Int = 0
    var presenter : MainPagePresentation?
    private var _suggestedProductList = [ProductDataModel]()
    private var _allProductList = [ProductDataModel]()
    
    private var _currentProduct : ProductDataModel = ProductDataModel(id: "", imageURL: "", price: 0, name: "", priceText: "", shortDescription: "", category: "", unitPrice: 0, squareThumbnailURL: "", status: 0, attribute: "", thumbnailURL: "", productCount: 0)
    
    //private var suggestedProductList : [SuggestedProductsResponse] = [SuggestedProductsResponse]()
    
    private lazy var headerView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .Theme.primaryColor
        return view
    }()
    
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Ürünler"
        label.font = UIFont(name: "OpenSans-Bold", size: 14)
        label.textAlignment = .center
        label.textColor = .Theme.white
        return label
    }()
    
    private lazy var basketMiniView = BasketMiniView(frame: .zero)

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
    
    private lazy var verticalCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: "ProductCell")
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        CoreDataStack.shared.deleteAllProducts()
        view.backgroundColor = .Theme.viewBackgroundColor
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(basketMiniViewTapped))
        basketMiniView.addGestureRecognizer(tapGesture)
        basketMiniView.isUserInteractionEnabled = true
        setupUI()
    }
    
    func displayTotalPrice(price: Double) {
        basketMiniView.setTotalPrice(price: price)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
        
        reloadVerticalCollectionView()
        reloadHorziontalCollectionView()
    }
    
    func reloadVerticalCollectionView() {
        DispatchQueue.main.async {
            self.verticalCollectionView.reloadData()
        }
    }
    
    func reloadHorziontalCollectionView() {
        DispatchQueue.main.async {
            self.horizontalCollectionView.reloadData()
        }
    }
    
    @objc private func basketMiniViewTapped(){
        presenter?.goShopingCartScreen()
    }
    
    func setupUI(){
        view.addSubview(headerView)
        headerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        headerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        
        headerView.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12).isActive = true
        
        view.addSubview(basketMiniView)
        basketMiniView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        basketMiniView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        basketMiniView.widthAnchor.constraint(equalToConstant: 90).isActive = true
        basketMiniView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        view.addSubview(horizontalCollectionView)
        horizontalCollectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20).isActive = true
        horizontalCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        horizontalCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        horizontalCollectionView.heightAnchor.constraint(equalToConstant: 190).isActive = true
        
        view.addSubview(verticalCollectionView)
        verticalCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 0).isActive = true
        verticalCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        verticalCollectionView.topAnchor.constraint(equalTo: horizontalCollectionView.bottomAnchor, constant: 20).isActive = true
        verticalCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == horizontalCollectionView{
            return presenter?.numberOfItems(collectionView: .horizontal) ?? 0
            
        }else{
            
            return presenter?.numberOfItems(collectionView: .vertical) ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCell else {
            fatalError("Unable to dequeue ProductCell")
        }
        if collectionView == horizontalCollectionView{
            
          
            if let suggestedProducts = presenter?.suggestedProductList(), !suggestedProducts.isEmpty {
                cell.configure(with: suggestedProducts[indexPath.row])
            }
        }else{
            if let allListProducts = presenter?.allProductList(), !allListProducts.isEmpty {
                cell.configure(with: allListProducts[indexPath.row])
            }
        }
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didSelect indexPath : \(indexPath.row)")
        if collectionView == horizontalCollectionView{
            presenter?.didSelectItem(collectionView: .horizontal, indexPath: indexPath.row)
           
        }else{
            presenter?.didSelectItem(collectionView: .vertical, indexPath: indexPath.row)
            
        }
    }
}

extension MainPageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == horizontalCollectionView{
            let cellWidth: CGFloat = 110
            let cellHeight: CGFloat = 150
            return CGSize(width: cellWidth, height: cellHeight)
        } else {
            let padding: CGFloat = 10
            let collectionViewSize = collectionView.frame.size.width - padding * 4
            return CGSize(width: collectionViewSize / 3, height: 150)
        }
    }
}

extension MainPageViewController : ProductCellButtonDelegate{
    func didTapPlusButton(in cell: UICollectionViewCell) {
        var indexPathForHorizontal : Int?
        var indexPathForVertical : Int?
        indexPathForHorizontal = self.horizontalCollectionView.indexPath(for: cell)?.row
        indexPathForVertical = self.verticalCollectionView.indexPath(for: cell)?.row
        presenter?.plusButtonTapped( indexPathHorizontal: indexPathForHorizontal, indexPathVertical: indexPathForVertical)
         
    }
    
    func productCountDidUpdate(in cell: UICollectionViewCell, newCount: Int) {
        presenter?.productCountChanged(count: newCount)
       
    }
    
}
