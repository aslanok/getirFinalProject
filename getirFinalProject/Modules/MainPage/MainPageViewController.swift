//
//  MainPageViewController.swift
//  getirFinalProject
//
//  Created by Okan Aslan on 16.04.2024.
//

import UIKit

protocol MainPageViewContract : UIViewController{
    func suggestedProductsFetched(productList : [SuggestedProductsResponse])
    func allProductsFetched(productList : [AllProductsResponse])

}

class MainPageViewController : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, MainPageViewContract{
    
    var presenter : MainPagePresentation?
    private var _suggestedProductList = [SuggestedProductsResponse]()
    private var _allProductList = [AllProductsResponse]()
    
    private var suggestedProductList : [SuggestedProductsResponse] = [SuggestedProductsResponse]()
    
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
    
    private lazy var basketMiniView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.backgroundColor = .Theme.white
        return view
    }()
    
    private lazy var miniBasketImageView : UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "miniBasketIcon"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var miniBasketAmountLabelView : CustomRoundedView = {
        let view = CustomRoundedView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .Theme.lightPurple
        view.cornerRadius = 6
        view.roundedCorners = [.topRight, .bottomRight]
        return view
    }()
    
    private lazy var miniBasketAmountLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "₺0,00"
        label.textColor = .Theme.primaryColor
        label.font = UIFont(name: "OpenSans-Bold", size: 14)
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
    
    private lazy var verticalCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        //layout.minimumLineSpacing = 10
        //layout.minimumInteritemSpacing = 10
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
        
        presenter?.fetchSuggestedProducts()
        presenter?.fetchAllProducts()
        view.backgroundColor = .Theme.viewBackgroundColor
        setupUI()

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
        
        basketMiniView.addSubview(miniBasketImageView)
        miniBasketImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        miniBasketImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        miniBasketImageView.leadingAnchor.constraint(equalTo: basketMiniView.leadingAnchor, constant: 5).isActive = true
        miniBasketImageView.centerYAnchor.constraint(equalTo: basketMiniView.centerYAnchor).isActive = true
        
        basketMiniView.addSubview(miniBasketAmountLabelView)
        miniBasketAmountLabelView.trailingAnchor.constraint(equalTo: basketMiniView.trailingAnchor, constant: -1).isActive = true
        miniBasketAmountLabelView.topAnchor.constraint(equalTo: basketMiniView.topAnchor, constant: 1).isActive = true
        miniBasketAmountLabelView.bottomAnchor.constraint(equalTo: basketMiniView.bottomAnchor, constant: -1).isActive = true
        miniBasketAmountLabelView.leadingAnchor.constraint(equalTo: miniBasketImageView.trailingAnchor, constant: 5).isActive = true
        
        miniBasketAmountLabelView.addSubview(miniBasketAmountLabel)
        miniBasketAmountLabel.centerXAnchor.constraint(equalTo: miniBasketAmountLabelView.centerXAnchor).isActive = true
        miniBasketAmountLabel.centerYAnchor.constraint(equalTo: miniBasketAmountLabelView.centerYAnchor).isActive = true
        
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
    
    func suggestedProductsFetched(productList: [SuggestedProductsResponse]) {
        _suggestedProductList = productList
        DispatchQueue.main.async {
            self.horizontalCollectionView.reloadData()
        }
    }
    
    func allProductsFetched(productList : [AllProductsResponse]){
        _allProductList = productList
        DispatchQueue.main.async {
            self.verticalCollectionView.reloadData()
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == horizontalCollectionView{
            if _suggestedProductList.isEmpty {
                return 0
            } else {
                return _suggestedProductList[0].products.count
            }
        }else{
            if _allProductList.isEmpty {
                return 0
            } else {
                return _allProductList[0].products?.count ?? 0
            }

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCell else {
            fatalError("Unable to dequeue ProductCell")
        }
        if collectionView == horizontalCollectionView{
            if _suggestedProductList.isEmpty == false {
                cell.configure(with: _suggestedProductList[0].products[indexPath.row])
            }
        }else{
            if _allProductList.isEmpty == false {
                cell.configure(with: _allProductList[0].products?[indexPath.row])
            }
        }
        cell.delegate = self
        return cell
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
        
        
        var product = ProductResponse(id: "", imageURL: nil, price: nil, name: nil, priceText: nil, shortDescription: nil, category: nil, unitPrice: nil, squareThumbnailURL: nil, status: nil, attribute: nil, thumbnailURL: nil)
        
        if indexPathForHorizontal == nil{
            product = _allProductList[0].products?[indexPathForVertical ?? 0] ?? ProductResponse(id: "", imageURL: nil, price: nil, name: nil, priceText: nil, shortDescription: nil, category: nil, unitPrice: nil, squareThumbnailURL: nil, status: nil, attribute: nil, thumbnailURL: nil)
        }else{
            product = _suggestedProductList[0].products[indexPathForHorizontal ?? 0]
        }
        
        presenter?.goPresentDetailPage(product: product)
    }
}
