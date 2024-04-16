//
//  ProductCell.swift
//  getirFinalProject
//
//  Created by Okan Aslan on 17.04.2024.
//

import UIKit

class ProductCell: UICollectionViewCell {
    // Define UI elements
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8  // Optional: rounded corners
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .darkText
        label.textAlignment = .center
        label.numberOfLines = 2  // Allows for wrapping if needed
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .systemGreen  // Makes the price stand out
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
        backgroundColor = .white  // Background color of the cell
        layer.cornerRadius = 10   // Rounded corners for the cell itself
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowColor = UIColor.black.cgColor
        
        // Add subviews
        addSubview(productImageView)
        addSubview(titleLabel)
        addSubview(priceLabel)
        
        // Constraints for image view
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            productImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            productImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            productImageView.heightAnchor.constraint(equalTo: productImageView.widthAnchor)  // Keep the aspect ratio 1:1
        ])
        
        // Constraints for title label
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)
        ])
        
        // Constraints for price label
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            priceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)  // Ensure there's space at the bottom
        ])
    }
    
    // Configure cell with data
    func configure(with product: Product) {
        productImageView.image = UIImage(named: product.imageName)
        titleLabel.text = product.title
        priceLabel.text = "\(product.price)"
    }
}

// Example Product model
struct Product {
    var title: String
    var price: String
    var imageName: String
}
