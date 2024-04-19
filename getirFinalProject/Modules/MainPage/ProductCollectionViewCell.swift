//
//  ProductCell.swift
//  getirFinalProject
//
//  Created by Okan Aslan on 17.04.2024.
//

import UIKit
import SDWebImage

class ProductCell: UICollectionViewCell {
    // Define UI elements
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8  // Optional: rounded corners
        imageView.sd_setImage(with: URL(string: "https://market-product-images-cdn.getirapi.com/product/62a59d8a-4dc4-4b4d-8435-643b1167f636.jpg"))
        return imageView
    }()
    
    private lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .darkText
        label.textAlignment = .center
        label.text = "Pr Name"
        label.numberOfLines = 2  // Allows for wrapping if needed
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.text = "Price"
        label.textColor = .Theme.primaryColor  // Makes the price stand out
        return label
    }()
    
    private lazy var attributeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .systemGreen  // Makes the price stand out
        label.text = "Attribute"
        return label
    }()
    
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
        self.backgroundColor = .black
        //layer.shadowOffset = CGSize(width: 0, height: 2)
        //layer.shadowColor = UIColor.black.cgColor
        
        // Add subviews
        addSubview(productImageView)
        addSubview(productNameLabel)
        addSubview(priceLabel)
        addSubview(attributeLabel)
        
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            productImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            productImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            productImageView.heightAnchor.constraint(equalTo: productImageView.widthAnchor)  // Keep the aspect ratio 1:1
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
    
    // Configure cell with data
    func configure(with product: ProductResponse) {
        //productImageView.image = UIImage(named: product.imageURL)
        //titleLabel.text = product.title
        //priceLabel.text = "\(product.price)"
    }
}

