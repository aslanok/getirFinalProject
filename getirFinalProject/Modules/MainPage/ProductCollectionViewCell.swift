//
//  ProductCell.swift
//  getirFinalProject
//
//  Created by Okan Aslan on 17.04.2024.
//

import UIKit
import SDWebImage

protocol ProductCellButtonDelegate : AnyObject{
    func didTapPlusButton(in cell: UICollectionViewCell)
    func productCountDidUpdate(in cell: UICollectionViewCell, newCount: Int)
}

class ProductCell: UICollectionViewCell, CountableBasketViewDelegate {

    weak var delegate : ProductCellButtonDelegate?
    
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.layer.borderColor = UIColor.Theme.lightPurple.cgColor
        imageView.layer.borderWidth = 1
        return imageView
    }()
    
    private lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .Theme.darkText
        label.textAlignment = .left
        label.text = "Kızılay Erzincan & Misket Limonu ve Nane Aromalı İçecek İkilisi"
        label.font = UIFont(name: "OpenSans-SemiBold", size: 12)
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "₺0,00"
        label.textAlignment = .left
        label.font = UIFont(name: "OpenSans-SemiBold", size: 14)
        label.textColor = .Theme.primaryColor  // Makes the price stand out
        return label
    }()
    
    private lazy var attributeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .Theme.grayText
        label.font = UIFont(name: "OpenSans-SemiBold", size: 12)
        label.textAlignment = .left
        label.text = "Attribute"
        return label
    }()
    
    private lazy var plusButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "plusIcon"), for: .normal)
        button.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var countableBasketView = CountableBasketView(frame: .zero, initialCount: 1 ,orientation: .vertical)
    
    // Initialize the cell
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Setup views
    private func setupViews() {
        countableBasketView.delegate = self
        self.backgroundColor = .clear
        //layer.shadowOffset = CGSize(width: 0, height: 2)
        //layer.shadowColor = UIColor.black.cgColor
        
        // Add subviews
        addSubview(productImageView)
        addSubview(productNameLabel)
        addSubview(priceLabel)
        addSubview(attributeLabel)
        addSubview(plusButton)
        
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            productImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            productImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            productImageView.heightAnchor.constraint(equalToConstant: 90),
            productImageView.widthAnchor.constraint(equalToConstant: 90)
        ])
        
        NSLayoutConstraint.activate([
            plusButton.topAnchor.constraint(equalTo: productImageView.topAnchor, constant: -10),
            plusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            plusButton.heightAnchor.constraint(equalToConstant: 32),
            plusButton.widthAnchor.constraint(equalToConstant: 32)
        ])
        
        
        
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 8),
            priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            productNameLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 2),
            productNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            productNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
        ])
        
        NSLayoutConstraint.activate([
            attributeLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 2),
            attributeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            attributeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
        ])
    }
    
    func addVerticalBasketView(){
        plusButton.isHidden = true
        countableBasketView.setInitialCount(count: 1)
        self.bringSubviewToFront(countableBasketView)
        self.addSubview(countableBasketView)
        countableBasketView.topAnchor.constraint(equalTo: plusButton.topAnchor, constant: 0).isActive = true
        countableBasketView.trailingAnchor.constraint(equalTo: plusButton.trailingAnchor).isActive = true
        countableBasketView.heightAnchor.constraint(equalToConstant: 96).isActive = true
        countableBasketView.widthAnchor.constraint(equalToConstant: 32).isActive = true
    }
    
    func removeVerticalBasketView(){
        countableBasketView.removeFromSuperview()
        plusButton.isHidden = false
        productImageView.layer.borderColor = UIColor.Theme.lightPurple.cgColor
        
    }
    
    @objc func plusButtonTapped(){
        delegate?.didTapPlusButton(in: self)
        productImageView.layer.borderColor = UIColor.Theme.primaryColor.cgColor
        addVerticalBasketView()
        print("plus Tapped")
    }
    
    func productCountDidUpdate(_ count: Int) {
        //print("currentCount : \(count)")
        delegate?.productCountDidUpdate(in: self, newCount: count)
        if count < 1{
            removeVerticalBasketView()
        }
    }
    
    // Configure cell with data
    func configure(with product: ProductDataModel) {
        productImageView.sd_setImage(with: URL(string: product.imageURL ?? product.squareThumbnailURL ?? product.thumbnailURL ?? ""))
        priceLabel.text = product.priceText ?? ""
        productNameLabel.text = product.name ?? ""
        attributeLabel.text = product.attribute ?? ""
    }
}

