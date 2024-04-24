//
//  DetailPageViewController.swift
//  getirFinalProject
//
//  Created by Okan Aslan on 19.04.2024.
//

import UIKit

protocol DetailPageViewContract : UIViewController {
    func displayTotalPrice(price : Double)
    func adjustComponents(count : Int)
}


class DetailPageViewController : UIViewController, DetailPageViewContract{
    
    
    var presenter : DetailPagePresentation?
    private var product : ProductDataModel
    
    init(product : ProductDataModel){
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var productGeneralView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .Theme.white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.clipsToBounds = false
        view.layer.masksToBounds = false
        return view
    }()
    
    private lazy var headerView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .Theme.primaryColor
        return view
    }()

    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Ürün Detayı"
        label.font = UIFont(name: "OpenSans-Bold", size: 14)
        label.textAlignment = .center
        label.textColor = .Theme.white
        return label
    }()

    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.sd_setImage(with: URL(string: product.imageURL ?? product.squareThumbnailURL ?? product.thumbnailURL ?? ""))
        imageView.layer.borderColor = UIColor.Theme.lightPurple.cgColor
        imageView.layer.borderWidth = 1
        return imageView
    }()
    
    private lazy var exitButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
        button.setImage(UIImage(named: "exitIcon"), for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = product.priceText ?? ""
        label.textAlignment = .center
        label.font = UIFont(name: "OpenSans-Bold", size: 20)
        label.textColor = .Theme.primaryColor  // Makes the price stand out
        return label
    }()
    
    private lazy var basketMiniView = BasketMiniView(frame: .zero)
    
    private lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .Theme.darkText
        label.textAlignment = .center
        label.text = product.name ?? ""
        label.font = UIFont(name: "OpenSans-SemiBold", size: 16)
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var attributeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .Theme.grayText
        label.font = UIFont(name: "OpenSans-SemiBold", size: 14)
        label.textAlignment = .center
        label.text = product.attribute ?? ""
        return label
    }()
    
    private lazy var addToBasketButton : UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sepete Ekle", for: .normal)
        button.backgroundColor = UIColor.Theme.primaryColor
        button.setTitleColor(.Theme.white, for: .normal)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 14)
        button.addTarget(self, action: #selector(addToBasketButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    private lazy var productBasketView = CountableBasketView(frame: .zero, initialCount: product.getProductCount() )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(basketMiniViewTapped))
        basketMiniView.addGestureRecognizer(tapGesture)
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
        //basketMiniView.setTotalPrice(price: CoreDataStack.shared.calculateTotalPrice())
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
        
        if product.getProductCount() > 0{
            basketMiniView.isHidden = false
            productBasketView.isHidden = false
            addToBasketButton.isHidden = true
            addToBasketButton.isUserInteractionEnabled = false
        }else{
            basketMiniView.isHidden = true
            productBasketView.isHidden = true
            addToBasketButton.isHidden = false
            addToBasketButton.isUserInteractionEnabled = true
        }
        
        view.addSubview(basketMiniView)
        basketMiniView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        basketMiniView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        basketMiniView.widthAnchor.constraint(equalToConstant: 90).isActive = true
        basketMiniView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        headerView.addSubview(exitButton)
        exitButton.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10).isActive = true
        exitButton.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -10).isActive = true
        exitButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        exitButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        view.addSubview(productGeneralView)
        productGeneralView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 0).isActive = true
        productGeneralView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        productGeneralView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        productGeneralView.heightAnchor.constraint(equalToConstant: 350).isActive = true

        productGeneralView.addSubview(productImageView)
        productImageView.topAnchor.constraint(equalTo: productGeneralView.topAnchor, constant: 20).isActive = true
        productImageView.centerXAnchor.constraint(equalTo: productGeneralView.centerXAnchor).isActive = true
        productImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        productImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        productGeneralView.addSubview(priceLabel)
        
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 20),
            priceLabel.leadingAnchor.constraint(equalTo: productGeneralView.leadingAnchor, constant: 20),
            priceLabel.trailingAnchor.constraint(equalTo: productGeneralView.trailingAnchor, constant: -20)
        ])
        
        productGeneralView.addSubview(productNameLabel)
        NSLayoutConstraint.activate([
            productNameLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 2),
            productNameLabel.leadingAnchor.constraint(equalTo: productGeneralView.leadingAnchor, constant: 20),
            productNameLabel.trailingAnchor.constraint(equalTo: productGeneralView.trailingAnchor, constant: -20),
        ])
        
        productGeneralView.addSubview(attributeLabel)
        NSLayoutConstraint.activate([
            attributeLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 2),
            attributeLabel.leadingAnchor.constraint(equalTo: productGeneralView.leadingAnchor, constant: 20),
            attributeLabel.trailingAnchor.constraint(equalTo: productGeneralView.trailingAnchor, constant: -20),
        ])
        
        productBasketView.delegate = self
        view.addSubview(productBasketView)
        productBasketView.translatesAutoresizingMaskIntoConstraints = false
        productBasketView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        productBasketView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        productBasketView.widthAnchor.constraint(equalToConstant: 140).isActive = true
        productBasketView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        
        view.addSubview(addToBasketButton)
        addToBasketButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        addToBasketButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        addToBasketButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        addToBasketButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
    }
    
    func displayTotalPrice(price: Double) {
        basketMiniView.setTotalPrice(price: price)
    }
    
    @objc func addToBasketButtonTapped(){
        productBasketView.setInitialCount(count: 1)
    }
    
    @objc private func basketMiniViewTapped(){
        presenter?.goShopingCartScreen()
    }
    
    func adjustComponents(count: Int) {
        if count > 0 {
            basketMiniView.isHidden = false
            productBasketView.isHidden = false
            addToBasketButton.isHidden = true
            addToBasketButton.isUserInteractionEnabled = false
        }else {
            basketMiniView.isHidden = true
            productBasketView.isHidden = true
            addToBasketButton.isHidden = false
            addToBasketButton.isUserInteractionEnabled = true
        }
    }
    
    @objc func exitButtonTapped(){
        presenter?.back()
    }
    
}

extension DetailPageViewController : CountableBasketViewDelegate {
    func productCountDidUpdate(_ count: Int) {
        presenter?.productCountUpdated(count: count)
        /*
        CoreDataStack.shared.addProduct(product: product, count: count)
        basketMiniView.setTotalPrice(price: CoreDataStack.shared.calculateTotalPrice())
        if count > 0 {
            basketMiniView.isHidden = false
            productBasketView.isHidden = false
            addToBasketButton.isHidden = true
            addToBasketButton.isUserInteractionEnabled = false
        }else {
            basketMiniView.isHidden = true
            productBasketView.isHidden = true
            addToBasketButton.isHidden = false
            addToBasketButton.isUserInteractionEnabled = true
        }
         */
    }
    
    
}
