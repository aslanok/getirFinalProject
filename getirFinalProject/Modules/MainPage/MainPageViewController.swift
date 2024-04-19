//
//  MainPageViewController.swift
//  getirFinalProject
//
//  Created by Okan Aslan on 16.04.2024.
//

import UIKit

protocol MainPageViewContract : UIViewController{
    
}

class MainPageViewController : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, MainPageViewContract{
    
    var presenter : MainPagePresentation?
    
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
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
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
        view.backgroundColor = .Theme.viewBackgroundColor
        setupUI()
        presenter?.fetchAllProducts()
        
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
        horizontalCollectionView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        view.addSubview(verticalCollectionView)
        verticalCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 0).isActive = true
        verticalCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        verticalCollectionView.topAnchor.constraint(equalTo: horizontalCollectionView.bottomAnchor, constant: 20).isActive = true
        verticalCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == horizontalCollectionView{
            return 10
        }else{
            return 40
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCell else {
            fatalError("Unable to dequeue ProductCell")
        }
                // Configure the cell
        //cell.backgroundColor = .lightGray // Example configuration
        return cell
    }
    
}

extension MainPageViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 10  // Assuming 10 points of padding
        let collectionViewSize = collectionView.frame.size.width - padding * 4 // Subtracts the padding and inter-item spacing
        return CGSize(width: collectionViewSize / 3, height: collectionViewSize / 3) // Creates a square cell
    }
}
