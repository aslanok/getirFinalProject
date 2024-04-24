//
//  ShoppingCartTableViewCell.swift
//  getirFinalProject
//
//  Created by Okan Aslan on 23.04.2024.
//

import UIKit

protocol ShoppingCartTableCellDelegate : AnyObject{
    func tableCellCountUpdated(cell : UITableViewCell,count : Int)
}

class ShoppingCartTableViewCell : UITableViewCell, CountableBasketViewDelegate{

    weak var delegate : ShoppingCartTableCellDelegate?
    public static var identifier : String = "ShoppingCartTableViewCell"
        
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.image = UIImage(named: "garbageIcon")
        imageView.layer.borderColor = UIColor.Theme.lightPurple.cgColor
        imageView.layer.borderWidth = 1
        return imageView
    }()
    
    private lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .Theme.darkText
        label.textAlignment = .left
        label.text = "Kızılay Erzincan & Misket Limonu ve Nane Aromalı İçecek İkilisi"
        label.font = UIFont(name: "OpenSans-SemiBold", size: 12)
        label.numberOfLines = 1
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

    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "₺0,00"
        label.textAlignment = .left
        label.font = UIFont(name: "OpenSans-SemiBold", size: 14)
        label.textColor = .Theme.primaryColor  // Makes the price stand out
        return label
    }()
    
    private lazy var countableBasketView = CountableBasketView(frame: .zero, initialCount: 1)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView(){
        contentView.backgroundColor = .Theme.white
        countableBasketView.delegate = self
        /*
        contentView.addSubview(priceLabel)
        priceLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        priceLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        priceLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        priceLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
         */
        
        contentView.addSubview(productImageView)
        productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        productImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        productImageView.heightAnchor.constraint(equalToConstant: 74).isActive = true
        productImageView.widthAnchor.constraint(equalToConstant: 74).isActive = true
        
        contentView.addSubview(productNameLabel)
        productNameLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 12).isActive = true
        productNameLabel.topAnchor.constraint(equalTo: productImageView.topAnchor, constant: 8).isActive = true
        productNameLabel.widthAnchor.constraint(equalToConstant: 125).isActive = true
        
        contentView.addSubview(attributeLabel)
        attributeLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 2).isActive = true
        attributeLabel.leadingAnchor.constraint(equalTo: productNameLabel.leadingAnchor).isActive = true
        attributeLabel.trailingAnchor.constraint(equalTo: productNameLabel.trailingAnchor).isActive = true
        
        contentView.addSubview(priceLabel)
        priceLabel.topAnchor.constraint(equalTo: attributeLabel.bottomAnchor, constant: 4).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: productNameLabel.leadingAnchor, constant: 0).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: productNameLabel.trailingAnchor, constant: 0).isActive = true
        
        countableBasketView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(countableBasketView)
        countableBasketView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        countableBasketView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        countableBasketView.widthAnchor.constraint(equalToConstant: 128).isActive = true
        countableBasketView.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    func countableBasketCountUpdated(_ count: Int) {
        print("tableCell count : \(count)")
        delegate?.tableCellCountUpdated(cell: self, count: count)
    }
    
    func configure(product : ProductDataModel){
        productImageView.sd_setImage(with: URL(string: product.imageURL ?? product.squareThumbnailURL ?? product.thumbnailURL ?? ""))
        priceLabel.text = product.priceText ?? ""
        productNameLabel.text = product.name ?? ""
        attributeLabel.text = product.attribute ?? ""
        //countableBasketView.setCountLabelText(count: product.getProductCount())
        countableBasketView.setInitialCount(count: product.getProductCount())
    }

}

