//
//  DetailPageViewController.swift
//  getirFinalProject
//
//  Created by Okan Aslan on 19.04.2024.
//

import UIKit

protocol DetailPageViewContract : UIViewController {
    
}


class DetailPageViewController : UIViewController, DetailPageViewContract{
    
    var presenter : DetailPagePresentation?
    private var product : ProductResponse
    
    init(product : ProductResponse){
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        imageView.sd_setImage(with: URL(string: "https://market-product-images-cdn.getirapi.com/product/ff43e9c8-a6a0-4444-923b-4972b2915284.png"))
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
        label.text = "₺0,00"
        label.textAlignment = .center
        label.font = UIFont(name: "OpenSans-Bold", size: 20)
        label.textColor = .Theme.primaryColor  // Makes the price stand out
        return label
    }()
    
    private lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .Theme.darkText
        label.textAlignment = .center
        label.text = "Kızılay Erzincan & Misket Limonu ve Nane Aromalı İçecek İkilisi"
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
        label.text = "Attribute"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
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
        
        headerView.addSubview(exitButton)
        exitButton.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10).isActive = true
        exitButton.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -10).isActive = true
        exitButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        exitButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        view.addSubview(productImageView)
        productImageView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20).isActive = true
        productImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        productImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        productImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        view.addSubview(priceLabel)
        
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 20),
            priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            priceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        view.addSubview(productNameLabel)
        NSLayoutConstraint.activate([
            productNameLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 2),
            productNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            productNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
        
        view.addSubview(attributeLabel)
        NSLayoutConstraint.activate([
            attributeLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 2),
            attributeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            attributeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    @objc func exitButtonTapped(){
        print("exitTapped")
        presenter?.back()
    }
    
}
