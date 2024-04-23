//
//  BasketMiniView.swift
//  getirFinalProject
//
//  Created by Okan Aslan on 20.04.2024.
//

import UIKit

class BasketMiniView: UIView {
    
    private lazy var miniBasketImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "miniBasketIcon"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var miniBasketAmountLabelView: CustomRoundedView = {
        let view = CustomRoundedView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .Theme.lightPurple
        view.layer.cornerRadius = 6
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

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView(){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .Theme.white
        self.layer.cornerRadius = 8
        
        addSubview(miniBasketImageView)
        addSubview(miniBasketAmountLabelView)
        miniBasketAmountLabelView.addSubview(miniBasketAmountLabel)
        
        NSLayoutConstraint.activate([
            miniBasketImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            miniBasketImageView.widthAnchor.constraint(equalToConstant: 24),
            miniBasketImageView.heightAnchor.constraint(equalToConstant: 24),
            miniBasketImageView.centerYAnchor.constraint(equalTo: centerYAnchor),

            miniBasketAmountLabelView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -1),
            miniBasketAmountLabelView.topAnchor.constraint(equalTo: topAnchor, constant: 1),
            miniBasketAmountLabelView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1),
            miniBasketAmountLabelView.leadingAnchor.constraint(equalTo: miniBasketImageView.trailingAnchor, constant: 5),
            
            miniBasketAmountLabel.centerXAnchor.constraint(equalTo: miniBasketAmountLabelView.centerXAnchor),
            miniBasketAmountLabel.centerYAnchor.constraint(equalTo: miniBasketAmountLabelView.centerYAnchor)
        ])
    }
    
    func setTotalPrice(price : Double){
        self.miniBasketAmountLabel.text = "₺\(NumberFormatterUtility.formatNumber(price))"
    }
    
}
